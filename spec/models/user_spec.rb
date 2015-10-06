require 'rails_helper'

RSpec.describe User, type: :model do
  it "makes sure the email is present" do
    user = FactoryGirl.build(:user, email: nil)
    expect(user).not_to                be_valid
    expect(user.errors[:email]).not_to be_empty
  end

  it "ensures the email is well-formed" do
    user = FactoryGirl.build(:user, email: "bad fake email")
    expect(user).not_to               be_valid
    expect(user.errors[:email]).not_to be_empty
  end

  it "ensures the email is unique" do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.build(:user, email: user1.email)
    expect(user1).to                    be_valid
    expect(user2).not_to                be_valid
    expect(user2.errors[:email]).not_to be_empty
  end

  it "ensures the password is present when user created" do
    user = FactoryGirl.build(:user, password: nil)
    expect(user).not_to                   be_valid
    expect(user.errors[:password]).not_to be_empty
  end

  it "ensures password confirmation is present on change" do
    user = FactoryGirl.build(
      :user, 
      password: "password", 
      password_confirmation: ""
    )
    expect(user).not_to                                be_valid
    expect(user.errors[:password_confirmation]).not_to be_empty
  end

  it "ensures password is confirmed on change" do
    user = FactoryGirl.build(
      :user, 
      password: "password",
      password_confirmation: "123"
    )
    expect(user).not_to                                be_valid
    expect(user.errors[:password_confirmation]).not_to be_empty
  end

  it "allows user authentication" do
    user = FactoryGirl.build(:user)
    expect(user.authenticate("password")).to be_truthy
    expect(user.authenticate("123")).to      be_falsey
  end
end
