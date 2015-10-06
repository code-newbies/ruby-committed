class DashboardsController < ApplicationController
  def new
    @user = User.find(session[:user_id])
  end
end
