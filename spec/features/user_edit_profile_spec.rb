require "rails_helper"

RSpec.describe "user edit profile" do
  let(:user) { create(:user) }

  before(:example) do
    signin(user)
    click_on "edit_user_link"
  end

  context "with valid attributes" do
    it "updates username successfully" do
      fill_in "user_username", with: "moeabdol"
      fill_in "user_current_password", with: user.password
      click_on "Update"
      expect(page).to have_selector("#username", text: "moeabdol")
    end

    it "updates email successfully" do
      fill_in "user_email", with: "moeabdol@example.com"
      fill_in "user_current_password", with: user.password
      click_on "Update"
      expect(page).to have_selector("#email", text: "moeabdol@example.com")
    end

    it "updates biography successfully" do
      fill_in "user_biography", with: "hello world"
      fill_in "user_current_password", with: user.password
      click_on "Update"
      expect(page).to have_selector("#biography", text: "hello world")
    end

    it "updates password successfully" do
      fill_in "user_password", with: "new password"
      fill_in "user_password_confirmation", with: "new password"
      fill_in "user_current_password", with: user.password
      click_on "Update"
      signout
      user.password = "new password"
      signin(user)
      expect(current_path).to eq(authenticated_root_path)
    end
  end

  context "with invalid attributes" do
    it "fails update when username is blank" do
      fill_in "user_username", with: ""
      fill_in "user_current_password", with: user.password
      click_on "Update"
      expect(page).to have_content("Username can't be blank")
    end

    it "fails update when email blank" do
      fill_in "user_email", with: ""
      fill_in "user_current_password", with: user.password
      click_on "Update"
      expect(page).to have_content("Email can't be blank")
    end

    it "fails update when password and confirmation don't match" do
      fill_in "user_password", with: "first password"
      fill_in "user_password_confirmation", with: "second password"
      fill_in "user_current_password", with: user.password
      click_on "Update"
      expect(page).to have_content("Password confirmation doesn't match " +
                                   "Password")
    end

    it "fails update if user forgets current password" do
      fill_in "user_username", with: "moeabdol"
      fill_in "user_current_password", with: "Oops! I forgot the password"
      click_on "Update"
      expect(page).to have_content("Current password is invalid")
    end
  end
end
