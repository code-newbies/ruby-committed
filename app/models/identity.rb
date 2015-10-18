class Identity < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :provider, presence: true, uniqueness: { scope: :user_id }
end
