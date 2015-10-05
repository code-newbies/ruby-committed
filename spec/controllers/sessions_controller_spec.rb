require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  it "prevents invalid users from signing in" do
    user = FactoryGirl.create(:user)
    post :create, email: user.email, password: ""
    assert_response(:success)
    expect(session[:user_id]).not_to eq(user.id)
  end

  it "signs in valid users" do
    user = FactoryGirl.create(:user)
    post :create, email: user.email, password: user.password
    assert_response(:redirect)
    expect(session[:user_id]).to eq(user.id)
  end
end
