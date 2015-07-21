class Feed < ActiveRecord::Base
	attr_reader	:feed, :entries

	has_many	:subscriptions
	has_many 	:articles

	after_create	:get_articles

	def get_articles
		@feed = Feedjira::Feed.fetch_and_parse(self.feed_url)
		self.url = self.feed.url
		@entries = self.feed.entries
		@entries.map! do |entry|
			article = articles.build(set_article: entry)
			article.save
		end
	end
end
