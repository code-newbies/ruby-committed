require "rails_helper"

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

RSpec.describe "user signin/signout" do
  let(:user) { create(:user) }

  context "regular signin/signout" do
    describe "sign in" do
      context "with valid attributes" do
        it "granted access" do
          signin(user)
          expect(current_path).to eq(authenticated_root_path)
        end
      end

      context "with invalid attributes" do
        it "denied access when provided wrong email" do
          user.email = "wrong_email@example.com"
          signin(user)
          expect(current_path).to eq(new_user_session_path)
        end

        it "denied access when provided wrong password" do
          user.password = "wrong password"
          signin(user)
          expect(current_path).to eq(new_user_session_path)
        end
      end

      it "denied access to unregistered user" do
        user = build(:user)
        signin(user)
        expect(current_path).to eq(new_user_session_path)
      end
    end

    describe "sign out" do
      it "signed in user can sign out" do
        signin(user)
        expect(current_path).to eq(authenticated_root_path)
        signout
        expect(current_path).to eq(root_path)
      end
    end
  end

  describe "social signin/signout" do
    describe "singin/signout with github" do
      before(:example) { mock_provider_auth_hash("github") }
      after(:example) { OmniAuth.config.mock_auth[:github] = nil }

      it "with valid credentials" do
        github_social_signin
        expect(current_path).to eq(authenticated_root_path)
      end

      it "with invalid credentials" do
        OmniAuth.config.mock_auth[:github] = :invalid_credentials
        github_social_signin
        expect(current_path).to eq(new_user_session_path)
      end

      it "signout successfully" do
        github_social_signin
        expect(current_path).to eq(authenticated_root_path)
        signout
        expect(current_path).to eq(root_path)
      end
    end
  end
end
