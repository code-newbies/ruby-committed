require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { build(:user) }

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

  describe "associations" do
    it "has many achievements" do
      achievement1 = build(:achievement)
      achievement2 = build(:achievement)
      user.achievements << achievement1 << achievement2
      expect(user.achievements.to_a.count).to eq 2
    end

    context "valid" do
      it "adds achievements to user" do
      achievement1 = build(:achievement)
      achievement2 = build(:achievement)
      user.achievements << achievement1 << achievement2 
      expect(user.save).to be true
      end
    end

    context "invalid" do
      it "does not add duplicate achievement to user" do
        achievement = build(:achievement)
        user.achievements << achievement << achievement 
        expect(user.save).to be false
      end
    end
  end
end
