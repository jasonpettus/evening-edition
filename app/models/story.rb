class Story < ActiveRecord::Base
	has_many 		:articles_stories
	has_many		:articles, through: :articles_stories
	belongs_to  :preferred_story, class_name: :Article
	belongs_to 	:user

	def other_sources
		articles.where("articles.id != #{preferred_story.id}")
	end

	def has_image?
    preferred_story.has_image?
  end

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
					p '*' * 50
					p img
					p img.src
					p '*' * 50
					img_src = img.src
					if img_src && img_src.match(/http:\/\//)
						all_img_urls << img_src
						# NEED TO USE FastImage
						dimensions = FastImage.size(img_src) # switched to this from FastImage to better handle 64bit (FILENAME too long)
						dimensions ? area = dimensions.reduce(:*) : area = 0
						if area > 100000
							img_areas << area
						else
							img_areas << 0
						end
					else
						all_img_urls << nil
						img_areas << 0
					end
				# img_src = "http://google.com"
				# all_img_urls << img_src
				# img_areas << 0
				end

			rescue ArgumentError, Errno::ETIMEDOUT, Mechanize::ResponseCodeError, Net::HTTPNotFound
				all_img_urls << nil
				img_areas << 0
			end
			p '-'*50
			p all_img_urls
			p img_areas
			p preferred_story.title
			largest = img_areas.index(img_areas.max)
			preferred_story.update_attributes(img_link: largest ? all_img_urls[largest] : 'NONE')
		end
	end

end
