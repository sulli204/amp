class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :username, presence: true,
                       uniqueness: { scope: :email }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: VALID_EMAIL_REGEX }

  validates :profile_page, presence: true,
                           uniqueness: true

  def to_param
    profile_page
  end
end
