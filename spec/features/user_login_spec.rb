require "rails_helper"

def login(user)
  visit new_user_session_path
  fill_in "user_email", with: user.email
  fill_in "user_password", with: user.password
  click_on "Log in"
end

def logout(user)
  click_on "Sign Out"
end

RSpec.describe "user login/logout" do
  let(:user) { create(:user) }

  describe "login" do
    context "with valid attributes" do
      it "granted access" do
        login(user)
        expect(current_path).to eq(authenticated_root_path)
      end
    end

    context "with invalid attributes" do
      it "denied access when provided wrong email" do
        user.email = "wrong_email@example.com"
        login(user)
        expect(current_path).to eq(new_user_session_path)
      end

      it "denied access when provided wrong password" do
        user.password = "wrong password"
        login(user)
        expect(current_path).to eq(new_user_session_path)
      end
    end

    it "denied access to unregistered user" do
      user = build(:user)
      login(user)
      expect(current_path).to eq(new_user_session_path)
    end
  end

  describe "logout" do
    it "logged in user can logout" do
      login(user)
      expect(current_path).to eq(authenticated_root_path)
      logout(user)
      expect(current_path).to eq(root_path)
    end
  end
end
