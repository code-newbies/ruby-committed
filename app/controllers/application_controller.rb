class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :devise_user_params, if: :devise_controller?

  private

  def devise_user_params
    devise_parameter_sanitizer.for(:sign_up) {
      |user| user.permit(:username, :email, :password, :password_confirmation)
    }

    devise_parameter_sanitizer.for(:account_update) {
      |user| user.permit(:username, :email, :biography, :password,
                         :password_confirmation, :current_password)
    }
  end
end
