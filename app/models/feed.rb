class Feed < ActiveRecord::Base
	belongs_to	:subscription
	belongs_to 	:article
end
