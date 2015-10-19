class UserAchievement < ActiveRecord::Base
  belongs_to :achievement
  belongs_to :user
  validates_uniqueness_of :achievement_id, scope: :user_id
end
