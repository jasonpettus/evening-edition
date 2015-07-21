require 'open-uri'
require 'mechanize'
require 'net/http'

class Subscription < ActiveRecord::Base
	has_many		:articles, through: :feed
	has_many		:stories, through: :user
	has_one			:user, through: :section
	belongs_to 	:section
	belongs_to  :feed

	def assign_feed=(feed_url)
		self.feed = Feed.where(feed_url: feed_url).first_or_create
	end
end
