class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    @identity = Identity.find_or_create_from_oauth(auth)
    if @identity.user.nil?
      create_identity_user_from_oauth
      signin_and_redirect_user
    elsif @identity.user.persisted?
      signin_and_redirect_user
    else
      session["devise.#{provider}_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  alias_method :github, :all

  private

  def auth
    @auth ||= request.env["omniauth.auth"]
  end

  def provider
    @provider ||= auth.provider
  end

  def create_identity_user_from_oauth
    @identity.user = User.create_from_oauth(auth)
    @identity.save
  end

  def signin_and_redirect_user
    sign_in_and_redirect @identity.user, event: :authentication
    set_flash_message(:notice, :success, kind: provider.to_sym)
  end
end
