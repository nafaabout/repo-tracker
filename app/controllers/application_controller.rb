# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include UserHelpers
  include Pagy::Backend
end
