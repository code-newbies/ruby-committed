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

  def signout(user)
    click_on "Sign Out"
  end
end
