class Article < ActiveRecord::Base
	belongs_to	:subscription
  SIMILARITY_WEIGHT = 0.45
  LIST_OF_WORDS_TO_IGNORE = ['a','an','the','to','and','of','be', 'in', 'at', 'this', 'that']

  def set_article=(article)
    self.title = article.title
    self.url = article.url
    self.last_modified = article.last_modified
    if article.summary
      self.summary = article.summary
    end
  end

  def is_similar_to?(article)
    subbed_title = remove_ignored_words(title)
    subbed_article_title = remove_ignored_words(article.title)

    Text::WhiteSimilarity.new.similarity(subbed_title, subbed_article_title) >= SIMILARITY_WEIGHT
  end

  private
    def remove_ignored_words(string)
      (string.downcase.split(' ') - LIST_OF_WORDS_TO_IGNORE).join(' ')
    end
end
