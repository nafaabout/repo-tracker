AUTH0_KEYS = Rails.application.credentials.dig(Rails.env.to_sym,:auth0)

Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    AUTH0_KEYS[:client_id],
    AUTH0_KEYS[:client_secret],
    AUTH0_KEYS[:domain],
    callback_path: '/auth/auth0/callback',
    authorize_params: {
      scope: 'openid profile email'
    }
  )
end

OmniAuth.config.on_failure = -> (env) do
  Rack::Response.new(['302 Moved'], 302, 'Location' => env['omniauth.origin'] || "/").finish
end
