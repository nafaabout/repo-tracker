# frozen_string_literal: true

module Authenticated
  extend ActiveSupport::Concern

  included do
    before_action :logged_in?
  end

  def logged_in?
    redirect_to root_path unless session[:user_id].present?
  end
end
