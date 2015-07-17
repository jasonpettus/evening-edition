class Article < ActiveRecord::Base
	belongs_to	:subscription

	def set_article=(article)
		self.title = article.title
		self.url = article.url
		self.last_modified = article.last_modified
		if article.summary
			self.summary = article.summary
		end
	end
end
