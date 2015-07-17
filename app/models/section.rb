class Section < ActiveRecord::Base
	has_many 	:subscriptions
	belongs_to	:user

	validates	:title, uniqueness: { scope: :user }
end
