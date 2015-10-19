class Achievement < ActiveRecord::Base
  validates :title,       presence: true, uniqueness: true
  validates :description, presence: true, uniqueness: true
  
  has_many :user_achievements
  has_many :users, through: :user_achievements
end
