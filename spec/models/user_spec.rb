require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations" do
    it "has a username" do
      user = build(:user, username: nil)
      expect(user).not_to be_valid
    end
  end

  context "omniauth" do
    it "creates user from ominauth hash" do
      expect {
        auth = OmniAuth::AuthHash.new({
          provider: :github,
          uid: "12345",
          info: {
            nickname: "moeabdol",
            email: "moeabdol@committed.com",
          }
        })
        User.create_from_oauth(auth)
      }.to change{ User.count }.from(0).to(1)
      expect(User.first.username).to eq("moeabdol")
      expect(User.first.email).to eq("moeabdol@committed.com")
    end
  end
end
