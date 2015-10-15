require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations" do
    it "must have a username" do
      user = build(:user, username: nil)
      expect(user).not_to be_valid
    end
  end
end
