require 'open-uri'
require 'net/http'
require 'mechanize'

class Subscription < ActiveRecord::Base
	attr_reader	:feed, :entries

	has_many		:articles, class_name: "Article"
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

	def get_feature_imgs(articles)
		feature_imgs = [] # => holds feature img srcs
		articles.map do |article| 
			all_img_urls = [] # => holds img srcs
			img_areas = [] # => holds dimensions
			# Nokogiri::HTML(open(article.url), :allow_redirections => :all){ |r| r.base_uri.to_s }.css('img').each do |node|
			# puts ">" * 50 + Net::HTTP.get_response(URI.parse(article.url)).code
			article_uri_obj = URI.parse(article.url)
			response = Net::HTTP.get_response(article_uri_obj)
			puts ">" * 50 + Net::HTTP.get_response(article_uri_obj).code
			if Net::HTTP.get_response(article_uri_obj).code.match(/30\d/) 
				# article_url = Net::HTTP.get_response(URI.parse(response.header['location']))
				article_url = response.header['location']
			end
			puts "<" * 50
			puts article_url #.match(/^[^\?]/)[0].to_s
			puts article_url.class
			# puts article_url.get_response #.match(/^[^\?]/)[0].to_s
			puts "<" * 50
			# puts ">" * 50 + article.url #.match(/^[^\?]/)[0].to_s
			puts ">" * 50 + article_url.match(/^[^\?]*/)[0]#.to_s
			Nokogiri::HTML(open(article_url.match(/[^\?]*/)[0]), :allow_redirections => :all){ |r| r.base_uri.to_s }.css('img').each do |node|
				all_img_urls << node.attr('src')
				img_areas << FastImage.size(node.attr('src')).reduce(1) { |length, width| length * width }
			end
			largest = img_areas.index(img_areas.max)
			feature_imgs << all_img_urls[largest]
		end
		return feature_imgs
	end

	private
		def save_articles
			strip_ads 
			self.articles.each { |article| article.save }
		end

		def strip_ads
			self.articles.each do |article|
				p article.summary.nil?
				unless article.summary.nil?
					no_images = article.summary.gsub!(/<img.*?>/,"")
					no_links = no_images.gsub!(/<a.*?<\/a>/,"")
					no_links.gsub!(/<br.*?>/,"")
				end
			end
		end
end
