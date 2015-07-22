class User < ActiveRecord::Base
  has_many :sections
  has_many :subscriptions, through: :sections
  has_many :stories, through: :sections
  has_many :favorited_stories, -> { where favorited: true }, class_name: 'Story'
  has_secure_password

  validates :email, presence: true, uniqueness: true
end
