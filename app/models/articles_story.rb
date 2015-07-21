class ArticlesStory < ActiveRecord::Base
	belongs_to	:story
	belongs_to 	:article
end
