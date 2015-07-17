class Section < ActiveRecord::Base
	has_many 	:subscriptions
	belongs_to	:user

	validates	:title, uniqueness: true # => like a "tag"; "category" 
end
