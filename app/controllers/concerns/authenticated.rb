# frozen_string_literal: true

module Authenticated
  extend ActiveSupport::Concern

  include UserHelpers

  included do
    before_action :ensure_logged_in
  end

  private

  def ensure_logged_in
    redirect_to root_path unless logged_in?
  end
end
