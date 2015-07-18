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

  def is_similar_to?(article)
    Text::WhiteSimilarity.new.similarity(title, article.title) >= 0.4
  end
end
