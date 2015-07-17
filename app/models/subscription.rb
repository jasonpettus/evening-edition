class Subscription < ActiveRecord::Base
	attr_reader	:feed, :entries

	has_many		:articles, class_name: "Article"
	belongs_to 	:section
	before_save	:get_articles
	after_save	:save_articles

	def set_feed=(rss)
		@feed = Feedjira::Feed.fetch_and_parse(rss)
		self.feed_url = rss
		self.url = self.feed.url
	end

	def get_articles
		@entries = self.feed.entries
		@entries.map! do |entry|
			Article.new(set_article: entry)
		end
		@entries.each { |entry| self.articles << entry }
	end

	private
		def save_articles
			@entries.each { |article| article.save }
		end
end
