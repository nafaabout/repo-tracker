# frozen_string_literal: true

class AuthenticationController < ApplicationController
  def callback
    # OmniAuth stores the informatin returned from Auth0 and the IdP in request.env['omniauth.auth'].
    # In this code, you will pull the raw_info supplied from the id_token and assign it to the session.
    # Refer to https://github.com/auth0/omniauth-auth0#authentication-hash for complete information on
    # 'omniauth.auth' contents.
    auth_info = request.env['omniauth.auth']
    user = create_user(build_user_attributes(auth_info))

    session[:user_id] = user.id
    # Redirect to the URL you want after successful auth
    redirect_to dashboard_path
  end

  def failure
    # Handles failed authentication -- Show a failure page (you can also handle with a redirect)
    @error_msg = request.params['message']
  end

  def logout
    reset_session
    redirect_to logout_url
  end

  private

  def auth0_keys
    @auth0_keys ||= Rails.application.credentials.dig(Rails.env.to_sym, :auth0) || {}
  end

  def logout_url
    request_params = {
      returnTo: root_url,
      client_id: auth0_keys[:client_id]
    }

    URI::HTTPS.build(host: auth0_keys[:domain], path: '/v2/logout', query: request_params.to_query).to_s
  end

  def create_user(user_attrs)
    user = User.find_or_initialize_by(uid: user_attrs[:uid])
    user.update(user_attrs.to_h)
    user
  end

  def build_user_attributes(auth_info)
    auth_info['info'].merge({
                              uid: auth_info['uid'],
                              token: auth_info['credentials']['token'],
                              token_type: auth_info['credentials']['token_type']
                            })
  end
end
