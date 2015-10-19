class Identity < ActiveRecord::Base
  belongs_to :user
  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :provider, presence: true, uniqueness: { scope: :user_id }

  def self.find_or_create_from_oauth(auth)
    first_or_create(provider: auth.provider, uid: auth.uid)
  end
end
