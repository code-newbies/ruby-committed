require "rails_helper"

RSpec.describe OmniauthCallbacksController, type: :controller do
  describe "POST #github" do
    before(:example) do
      request.env["devise.mapping"] = Devise.mappings[:user]
      request.env["omniauth.auth"] = mock_provider_auth_hash("github")
    end

    context "first time social sign in" do
      it "assigns @identity" do
        get :github
        expect(assigns(:identity)).to be_a(Identity)
        expect(assigns(:identity).provider).to eq("github")
        expect(assigns(:identity).uid).to eq("12345")
      end

      it "creates a user" do
        expect(User).to receive(:create_from_oauth).and_return(
          create(:user, username: request.env["omniauth.auth"].info.nickname,
                        email: request.env["omniauth.auth"].info.email))
        get :github
      end

      it "redirects to authenticated_root_path" do
        get :github
        expect(response).to redirect_to("/")
      end
    end

    context "user already exists" do
      before(:example) do
        @user = create(:user,
                       username: request.env["omniauth.auth"].info.nickname,
                       email: request.env["omniauth.auth"].info.email)
        @identity = create(:identity,
                           provider: request.env["omniauth.auth"].provider,
                           uid: request.env["omniauth.auth"].uid,
                           user: @user)
      end

      it "assigns @identity" do
        get :github
        expect(assigns(:identity)).to eq(@identity)
        expect(assigns(:identity).user).to eq(@user)
        expect(assigns(:identity).provider).to eq("github")
        expect(assigns(:identity).uid).to eq("12345")
      end

      it "does not create a new user" do
        expect(User).not_to receive(:create_from_oauth)
        get :github
      end

      it "redirects to authenticated_root_path" do
        get :github
        expect(response).to redirect_to("/")
      end
    end

    context "invalid credintials" do
      before(:example) do
        @user = build(:user,
                       username: request.env["omniauth.auth"].info.nickname,
                       email: request.env["omniauth.auth"].info.email)
        @identity = create(:identity,
                           provider: request.env["omniauth.auth"].provider,
                           uid: request.env["omniauth.auth"].uid)
        @identity.user = @user
        allow(Identity).to \
          receive(:find_or_create_from_oauth).and_return(@identity)
      end

      it "assigns session" do
        get :github
        expect(session["devise.github_data"]).to \
          eq(request.env["omniauth.auth"])
      end

      it "redirects to new_user_registration_url" do
        get :github
        expect(response).to redirect_to(new_user_registration_url)
      end
    end
  end
end
