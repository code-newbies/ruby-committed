class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.where(
      "email = ? AND verified_at IS NOT NULL",
      params[:email]
    ).first
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      flash.now[:alert] = "Email or password didn't match"
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to signin_path
  end
end
