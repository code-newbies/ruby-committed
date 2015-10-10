require 'rails_helper'

RSpec.describe Achievement, type: :model do

  let(:achievement) { build(:achievement) }

  describe "validation" do

    it "has a valid factory" do
      expect(achievement).to be_valid
    end

    it "is invalid without a title" do
      achievement.title = nil 
      expect(achievement).to be_invalid
    end

    it "is invalid without a description" do
      achievement.description = nil 
      expect(achievement).to be_invalid
    end

    it "is invalid if title already exists" do
      achievement.save
      duplicate_achievement = build(:achievement)
      duplicate_achievement.title = achievement.title
      expect(duplicate_achievement).to be_invalid
    end

    it "is invalid if description already exists" do
      achievement.save
      duplicate_achievement = build(:achievement)
      duplicate_achievement.description = achievement.description
      expect(duplicate_achievement).to be_invalid
    end
  end
end
