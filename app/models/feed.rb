class Feed < ActiveRecord::Base
	belongs_to	:subscription
	belongs_to 	:article

	def get_articles
		@feed = Feedjira::Feed.fetch_and_parse(self.feed_url)
		self.url = self.feed.url
		@entries = self.feed.entries
		@entries.map! do |entry|
			Article.new(set_article: entry)
		end
		@entries.each { |entry| self.articles << entry }
	end

	def save_articles
		strip_ads
		get_feature_imgs(self.articles)
		self.articles.each { |article| article.save }
	end
end
