require 'rails_helper'

RSpec.describe Identity, type: :model do
  context "validations" do
    it "has a uid" do
      identity = build(:identity, uid: nil)
      expect(identity).not_to be_valid
    end

    it "has a provider" do
      identity = build(:identity, provider: nil)
      expect(identity).not_to be_valid
    end

    context "uniquness constraints" do
      let(:user) { create(:user) }

      it "different identites cannot have same uid for the same provider" do
        create(:identity, user: user, provider: "github", uid: "123")
        identity = build(:identity, user: user, provider: "github", uid: "123")
        expect(identity).not_to be_valid
      end

      it "same user cannot have multiple identites with the same provider" do
        create(:identity, user: user, provider: "github")
        identity = build(:identity, user: user, provider: "github")
        expect(identity).not_to be_valid
      end

      it "different identities can have same provider with different uids" do
        create(:identity, user: user, provider: "github", uid: "123")
        identity = build(:identity, user: create(:user), provider: "github",
                                                         uid: "456")
        expect(identity).to be_valid
      end

      it "different identities can have same uid with different provider" do
        create(:identity, provider: "github", uid: "123")
        identity = build(:identity, provider: "twitter", uid: "123")
        expect(identity).to be_valid
      end
    end
  end

  context "omniauth" do
    before(:example) do
      @auth = OmniAuth::AuthHash.new({
        provider: :github,
        uid: "12345",
        info: {
          nickname: "moeabdol",
          email: "moeabdol@committed.com",
        }
      })
    end

    it "creates a new social identity if identity is not found" do
      expect(Identity.count).to eq(0)
      identity = Identity.find_or_create_from_oauth(@auth)
      expect(Identity.count).to eq(1)
      expect(identity.provider).to eq("github")
      expect(identity.uid).to eq("12345")
    end

    it "finds an already created social identity" do
      create(:identity, provider: "github", uid: "12345")
      expect(Identity.count).to eq(1)
      identity = Identity.find_or_create_from_oauth(@auth)
      expect(Identity.count).to eq(1)
      expect(identity.provider).to eq("github")
      expect(identity.uid).to eq("12345")
    end
  end
end
