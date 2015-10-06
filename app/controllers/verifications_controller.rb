require "securerandom"

class VerificationsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @user.verification_token = SecureRandom.hex(20)
    @user.save!
    UserMailer.verify(@user).deliver_now
  end

  def create
    @user = User.find_by(verification_token: params[:token])
    @user.verified_at = Time.now
    @user.save!
    flash[:notice] = "Email verified. Please sign in."
    redirect_to signin_path
  end
end
