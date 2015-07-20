require 'open-uri'
require 'mechanize'
require 'net/http'

class Subscription < ActiveRecord::Base

	attr_reader	:feed, :entries

	has_many		:articles, dependent: :destroy
	has_many	:recent_articles, -> { order("created_at DESC").limit(5) }, class_name: 'Article'
	has_one		:user, through: :section
	belongs_to 	:section

	def get_articles
		@feed = Feedjira::Feed.fetch_and_parse(self.feed_url)
		self.url = self.feed.url
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
			response = Net::HTTP.get_response(URI.parse(URI.encode(article.url)))
			puts ">" * 50 + response.code
			begin
				if response.code.match(/30\d/)
					article_url = response.header['location']
					# article_url = ""
				else
					article_url = article.url
				end
				agent =  Mechanize.new
				page = agent.get(URI.encode(article_url))
				page.images.each do |img|
					p ">" * 25
					p img
					p ">" * 25
					img_src = img.src
					p "<" * 25
					p img_src
					p "<" * 25
					if img_src && img_src.match(/http:\/\//)
						all_img_urls << img_src
						# NEED TO USE FastImage
						img = ImageInfo.from(img_src)[0] # switched to this from FastImage to better handle 64bit (FILENAME too long)
						img ? area = img.size.reduce(1) { |length, width| length * width } : area = 0
						if area > 5000
							img_areas << area
						else 
							img_areas << 0
						end
					else
						all_img_urls << nil
						img_areas << 0
					end
				img_src = "http://google.com"
				all_img_urls << img_src
				img_areas << 0
				end
				rescue ArgumentError, Errno::ETIMEDOUT, Mechanize::ResponseCodeError, Net::HTTPNotFound
						all_img_urls << nil
						img_areas << 0
				end

			largest = img_areas.index(img_areas.max)
			largest ? feature_imgs << all_img_urls[largest] : feature_imgs << nil
			article.img_link = feature_imgs[-1]
		end
		return feature_imgs
	end

	def save_articles
		strip_ads
		get_feature_imgs(self.articles)
		self.articles.each { |article| article.save }
	end


	private

		def strip_ads
			decoder =  HTMLEntities.new
			self.articles.each do |article|
				unless article.summary.nil?
						stripped_summary = article.summary.gsub(/<img.*?>/m,"").gsub(/<.*?<\/.*?>/m,"")
						decoded_summary = decoder.decode(stripped_summary)
						article.summary = decoded_summary
				end
				
				unless article.title.nil?
						stripped_title = article.title.gsub(/<.*?<\/.*?>/m,"")
						decoded_title = decoder.decode(stripped_title)
						article.title = decoded_title
				end
			end
		end

end
