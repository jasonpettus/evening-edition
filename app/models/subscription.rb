require 'open-uri'

class Subscription < ActiveRecord::Base
	attr_reader	:feed, :entries

	has_many		:articles, dependent: :destroy
	has_one		:user, through: :section
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

	def get_feature_imgs
		feature_imgs = []
		img_areas = []
		@entries.map do |entry|
			Nokogiri::HTML(open(entry.url)).css('img').each do |node|
				feature_imgs << node.attr('src')
				img_areas << FastImage.size(node.attr('src')).reduce(1) { |length, width| length * width }
			end
			largest = img_areas.index(img_areas.max)
			
		end
	end

	private
		def save_articles
			strip_ads
			@entries.each { |article| article.save }
		end

		def strip_ads
			@entries.each do |entry|
				if entry.summary.include? "<img"
					no_images = entry.summary.gsub!(/<img.*?>/,"")
				elsif entry.summary.include? "</a>"
					no_links = no_images.gsub!(/<a.*?<\/a>/,"")
				elsif entry.summary.include? "<br"
					no_links.gsub!(/<br.*?>/,"")
				end
			end
		end
end
