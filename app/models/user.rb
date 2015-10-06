class User < ActiveRecord::Base
  has_secure_password

  validates :email,
            presence: true,
            format: /\A[^@\s]+@[^@\s]+\z/,
            uniqueness: true
end
