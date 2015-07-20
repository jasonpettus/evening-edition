class Article < ActiveRecord::Base
	belongs_to	:subscription
  SIMILARITY_WEIGHT = 0.40
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

    white_similarity_on_words(subbed_title, subbed_article_title) >= SIMILARITY_WEIGHT
  end

  private
    def remove_ignored_words(string)
      (string.downcase.split(' ') - LIST_OF_WORDS_TO_IGNORE).join(' ')
    end

    def white_similarity_on_words(str1, str2)
      pairs1 = str_to_words(str1)
      pairs2 = str_to_words(str2).dup

      union = pairs1.length + pairs2.length

      intersection = 0
      pairs1.each do |pair1|
        if index = pairs2.index(pair1)
          intersection += 1
          pairs2.delete_at(index)
        end
      end
      p union
      p intersection
      (2.0 * intersection) / union
    end

    def str_to_words(str)
      p 'Hello'
      str.gsub(/[\,\.\;\:\'\"\!\@\#\$\%\^\&\*\(\)\_\+]/, '').split(' ')
    end
end
