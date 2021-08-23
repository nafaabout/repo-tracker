class HomeController < ApplicationController
  def index
    @user = session[:userinfo]
  end
end
