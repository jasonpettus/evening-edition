class User < ActiveRecord::Base
  has_many :sections
  has_many :subscriptions, through: :sections
  has_secure_password
end
