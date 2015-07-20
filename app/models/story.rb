class Story < ActiveRecord::Base
	has_many 		:articles_stories
	has_many		:articles, through: :articles_stories
	belongs_to 	:user
end
