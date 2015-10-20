module SessionHelpers
  def signup(user)
    visit new_user_registration_path
    fill_in "user_username", with: user.username
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    fill_in "user_password_confirmation", with: user.password
    click_on "Sign up"
  end

  def signin(user)
    visit new_user_session_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_on "Log in"
  end

  def signout
    click_on "Sign Out"
  end

  def github_social_signin
    visit root_path
    click_on "Sign In"
    click_on "Sign in with Github"
  end

  def mock_provider_auth_hash(provider)
    OmniAuth.config.mock_auth[provider.to_sym] = OmniAuth::AuthHash.new({
      provider: provider.to_sym,
      uid: "12345",
      info: {
        nickname: "moeabdol",
        email: "moeabdol@committed.com",
      }
    })
  end
end
