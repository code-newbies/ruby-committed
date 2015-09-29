class Achievement < ActiveRecord::Base
  validates :title,       presence: true, uniqueness: true
  validates :description, presence: true, uniqueness: true
end
