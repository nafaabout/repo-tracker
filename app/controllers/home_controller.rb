# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @user = User.find_by(id: session[:user_id])
  end
end
