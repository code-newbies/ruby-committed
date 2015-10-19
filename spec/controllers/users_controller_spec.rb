require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #show" do
    before(:example) do
      @user = create(:user)
      sign_in(@user)
      get :show, id: @user
    end

    it "assigns @user" do
      expect(assigns(:user)).to eq(@user)
    end

    it "renders show template" do
      expect(response).to render_template(:show)
    end
  end
end
