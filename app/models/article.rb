class Article < ActiveRecord::Base
  belongs_to  :feed
  has_many :subscriptions, through: :feed
  has_many :articles_stories
  has_many :stories, through: :articles_stories

  SIMILARITY_WEIGHT = 0.40
  LIST_OF_WORDS_TO_IGNORE = ['a','an','the','to','and','of','be', 'in', 'at', 'this', 'that']

  before_create :strip_ads

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
    # Text::WhiteSimilarity.new.similarity(subbed_title, subbed_article_title) >= SIMILARITY_WEIGHT
    white_similarity_on_words(subbed_title, subbed_article_title) >= SIMILARITY_WEIGHT
  end

  def has_image?
    img_link && img_link != 'NONE'
  end

  def strip_ads
    decoder =  HTMLEntities.new
    unless summary.nil?
      stripped_summary = summary.gsub(/(<[^>]*>)|\n|\t/,"")
      decoded_summary = decoder.decode(stripped_summary)

      if self.summary.length > 20
        self.summary = decoded_summary.split(" ").slice(0..20).push("...").join(" ")
      end
    end

    unless title.nil?
      stripped_title = title.gsub(/(<[^>]*>)|\n|\t/,"")
      decoded_title = decoder.decode(stripped_title)
      self.title = decoded_title
    end
  end

  def news_source(section_id)
    subscriptions.where("section_id = #{section_id}").first.name
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
      # p union
      # p intersection
      (2.0 * intersection) / union
    end

    def str_to_words(str)
      # p 'Hello'
      str.gsub(/[\,\.\;\:\'\"\!\@\#\$\%\^\&\*\(\)\_\+]/, '').split(' ')
    end
end
