class UserMailer < ApplicationMailer
  default from: "donotreply@rubycommited.com"

  def verify(user)
    @user = user
    mail to: @user.email, subject: "[Ruby Committed] Verify Email"
  end

  def reset_password(user)
    @user = user
    mail to: @user.email, subect: "[Ruby Committed] Reset Password"
  end
end
