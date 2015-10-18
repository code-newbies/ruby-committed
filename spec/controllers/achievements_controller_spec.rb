require 'rails_helper'

RSpec.describe AchievementsController, type: :controller do

  let(:achievement) { create(:achievement) }

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new) 
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates an achievement" do
        post :create, achievement: attributes_for(:achievement)
        expect(Achievement.count).to eq(1)
      end

       it "redirects to the new achievement" do
        post :create, achievement: attributes_for(:achievement)
        expect(response).to redirect_to Achievement.first
      end
    end

    context "with invalid attributes" do
        it 'does not save the achievement' do
        post :create, achievement: attributes_for(:achievement, title: nil)
        expect(Achievement.count).to eq(0)
      end

      it "renders the new template" do
        post :create, achievement: attributes_for(:achievement, title: nil)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #show" do
    it "renders the show template" do
      get :show, id: achievement
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show) 
    end
  end

  describe "GET #index" do
    it "renders the index template" do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index) 
    end
  end

  describe "GET #edit" do
    it "renders the edit form" do
      get :edit, id: achievement
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:edit) 
    end
  end

  describe "PUT #update" do
    it "returns http success" do
      put :update, id: achievement, achievement: attributes_for(:achievement)
      expect(Achievement.first.title).to_not eq achievement.title
    end
  end

  describe "DELETE #destroy" do
    it "returns http success" do
      delete :destroy, id: achievement
      expect(Achievement.count).to eq(0)
    end
  end
end
