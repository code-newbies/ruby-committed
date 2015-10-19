class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:github]
  has_many :identities
  has_many :user_achievements
  has_many :achievements, through: :user_achievements
  validates :username, presence: true

  def self.create_from_oauth(auth)
    create(username: auth.info.nickname,
           email: auth.info.email,
           password: Devise.friendly_token[0, 20])
  end
end
