require "rails_helper"

def signup(user)
  visit new_user_registration_path
  fill_in "user_username", with: user.username
  fill_in "user_email", with: user.email
  fill_in "user_password", with: user.password
  fill_in "user_password_confirmation", with: user.password
  click_on "Sign up"
end

RSpec.describe "user signup" do
  let(:user) { build(:user) }

  context "with valid attributes" do
    it "registered successfully" do
      signup(user)
      expect(current_path).to eq(authenticated_root_path)
    end
  end

  context "with invalid attributes" do
    it "failes registrations when user does not provid a username" do
      user.username = nil
      signup(user)
      expect(page).to have_content("Username can't be blank")
    end

    it "failes registrations when user does not provid a email" do
      user.email = nil
      signup(user)
      expect(page).to have_content("Email can't be blank")
    end

    it "failes registrations when user does not provid a password" do
      user.password = nil
      signup(user)
      expect(page).to have_content("Password can't be blank")
    end
  end
end
