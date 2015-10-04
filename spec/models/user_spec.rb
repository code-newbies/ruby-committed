require 'rails_helper'

RSpec.describe User, type: :model do
  it "makes sure the email is present" do
    user = FactoryGirl.build(:user, email: nil)
    expect(user).not_to be_valid
    expect(user.errors[:email]).not_to be_empty
  end
end
