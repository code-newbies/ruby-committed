require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  it "creates new users" do
    attributes = {user: FactoryGirl.attributes_for(:user) }
    expect(User.find_by(email: attributes[:user][:email])).to be_nil
    post :create, attributes
    assert_response(:redirect)
    expect(User.find_by(email: attributes[:user][:email])).not_to be_nil
  end

  it "returns the form if there are errors" do
    attributes = {user: FactoryGirl.attributes_for(:user) }
    attributes[:user][:password] = ""
    expect(User.find_by(email: attributes[:user][:email])).to be_nil
    post :create, attributes
    assert_response(:redirect)
    user = assigns[:user]
    expect(user.email).to eq(attributes[:user][:email])
    expect(User.find_by(email: attributes[:user][:email])).to be_nil
  end
end
