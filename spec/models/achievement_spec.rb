require 'rails_helper'

RSpec.describe Achievement, type: :model do

  it { should respond_to(:id) }
  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }

  describe "validation" do

    let(:achievement) { build(:achievement) }

    it "accepts valid attributes" do
      expect(achievement).to be_valid
    end

    it "rejects blank title" do
      achievement.title = "    "
      expect(achievement).to_not be_valid
    end

    it "rejects blank description" do
      achievement.description = "    "
      expect(achievement).to_not be_valid
    end

    it "rejects duplicate title" do
      achievement.save
      duplicate_achievement = build(:achievement)
      duplicate_achievement.title = achievement.title
      expect(duplicate_achievement).to_not be_valid
    end

    it "rejects duplicate description" do
      achievement.save
      duplicate_achievement = build(:achievement)
      duplicate_achievement.description = achievement.description
      expect(duplicate_achievement).to_not be_valid
    end
  end
end
