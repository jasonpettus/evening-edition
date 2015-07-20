class Story < ActiveRecord::Base
	has_many 		:articles_stories
	has_many		:articles, through: :articles_stories
	belongs_to  :preferred_story, class_name: :Article
	belongs_to 	:user

	def fetch_img
		unless preferred_story.has_image?
			all_img_urls = [] # => holds img srcs
			img_areas = [] # => holds dimensions
			response = Net::HTTP.get_response(URI.parse(URI.encode(preferred_story.url)))
			begin
				if response.code.match(/30\d/)
					article_url = response.header['location']
				else
					article_url = preferred_story.url
				end
				agent = Mechanize.new
				page = agent.get(URI.encode(article_url))
				page.images.each do |img|
					img_src = img.src
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
			largest ? preferred_story.img_link = all_img_urls[largest] : preferred_story.img_link = 'NONE'
		end
	end


	# def get_feature_imgs(articles) # => Takes 13s for 20 articles from "http://rss.nytimes.com/services/xml/rss/nyt/Science.xml" feed
	# 	feature_imgs = [] # => holds feature img srcs
	# 	articles.map do |article|
	# 		all_img_urls = [] # => holds img srcs
	# 		img_areas = [] # => holds dimensions
	# 		response = Net::HTTP.get_response(URI.parse(URI.encode(article.url)))
	# 		# puts ">" * 50 + response.code
	# 		begin
	# 			if response.code.match(/30\d/)
	# 				article_url = response.header['location']
	# 			else
	# 				article_url = article.url
	# 			end
	# 			agent =  Mechanize.new
	# 			page = agent.get(URI.encode(article_url))
	# 			page.images.each do |img|
	# 				# p ">" * 25
	# 				# p img
	# 				# p ">" * 25
	# 				img_src = img.src
	# 				# p "<" * 25
	# 				# p img_src
	# 				# p "<" * 25
	# 				if img_src && img_src.match(/http:\/\//)
	# 					all_img_urls << img_src
	# 					# NEED TO USE FastImage
	# 					img = ImageInfo.from(img_src)[0] # switched to this from FastImage to better handle 64bit (FILENAME too long)
	# 					img ? area = img.size.reduce(1) { |length, width| length * width } : area = 0
	# 					if area > 5000
	# 						img_areas << area
	# 					else
	# 						img_areas << 0
	# 					end
	# 				else
	# 					all_img_urls << nil
	# 					img_areas << 0
	# 				end
	# 			img_src = "http://google.com"
	# 			all_img_urls << img_src
	# 			img_areas << 0
	# 			end
	# 			rescue ArgumentError, Errno::ETIMEDOUT, Mechanize::ResponseCodeError, Net::HTTPNotFound
	# 					all_img_urls << nil
	# 					img_areas << 0
	# 			end

	# 		largest = img_areas.index(img_areas.max)
	# 		largest ? feature_imgs << all_img_urls[largest] : feature_imgs << nil
	# 		article.img_link = feature_imgs[-1]
	# 	end
	# 	return feature_imgs
	# end
end
