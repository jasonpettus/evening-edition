class User < ActiveRecord::Base
  has_many :sections
  has_many :subscriptions, through: :sections
  has_many :stories
  has_secure_password

  validates :email, presence: true
end
