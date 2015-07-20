class Articles_Story < ActiveRecord::Base
	belongs_to	:story
	belongs_to 	:article
end
