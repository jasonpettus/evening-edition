require 'open-uri'
require 'mechanize'
require 'net/http'

class Subscription < ActiveRecord::Base

	attr_reader	:feed, :entries

	has_many		:articles, dependent: :destroy
	has_one		:user, through: :section
	belongs_to 	:section
	before_save	:get_articles
	after_save	:save_articles

	def set_feed=(rss)
		@feed = Feedjira::Feed.fetch_and_parse(rss) #--***
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

	def get_feature_imgs(articles) # => Takes 13s for 20 articles from "http://rss.nytimes.com/services/xml/rss/nyt/Science.xml" feed
		feature_imgs = [] # => holds feature img srcs
		articles.map do |article|
			all_img_urls = [] # => holds img srcs
			img_areas = [] # => holds dimensions
			response = Net::HTTP.get_response(URI.parse(article.url))
			puts ">" * 50 + response.code
			begin
			if response.code.match(/30\d/)
				article_url = response.header['location']
				# article_url = ""
			else
				article_url = article.url
			end

			rescue ArgumentError
			agent = Mechanize.new
				page = agent.get(article_url)
				page.images.each do |img|
						p ">" * 25 
						p img
						p ">" * 25 
					img_src = img.src 
					if img_src 
						all_img_urls << img_src 
						img = ImageInfo.from(img_src)[0] # switched to this from FastImage to better handle 64bit (FILENAME too long)
						img ? area = img.size.reduce(1) { |length, width| length * width } : area = 0
						img_areas << area
					else
						all_img_urls << "NONE"
						img_areas << 0
					end
				img_src = "http://google.com"
				all_img_urls << img_src
				img_areas << 0
			end
				end

			largest = img_areas.index(img_areas.max)
			largest ? feature_imgs << all_img_urls[largest] : feature_imgs << "NONE"
			article.img_link = feature_imgs[-1]
		end
		return feature_imgs
	end

	private
		def save_articles
			strip_ads
			get_feature_imgs(self.articles)
			self.articles.each { |article| article.save }
		end

		def strip_ads
			self.articles.each do |article|
				unless article.summary.nil?
						stripped = article.summary.gsub(/<img.*?>/,"").gsub(/<a.*?<\/a>/,"").gsub(/<br.*?>/,"")
						article.summary = stripped
				end
			end
		end
end
