class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user && @user.valid?
      @user.save!
      redirect_to verify_path(user_id: @user.id)
    else
      redirect_to signup_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end