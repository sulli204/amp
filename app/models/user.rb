class User < ApplicationRecord
  has_secure_password

  has_many :songs

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: VALID_EMAIL_REGEX }

  validates :name, presence: true
  validates :username, presence: true
end
