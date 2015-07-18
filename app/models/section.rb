class Section < ActiveRecord::Base
	has_many 	:subscriptions
	belongs_to	:user
  has_many :articles, through: :subscriptions

	validates	:title, uniqueness: { scope: :user }


  def stories
    # Get all the articles
    # Check article similarity with other articles
    # Group by similarity
    cluster_articles(articles)
  end

  private
  def cluster_articles(articles)
    # p articles.length
    # p articles
    articles = articles.map { |x| x }
    clusters = []
    while articles.length > 0
      n = 0
      clusters << []
      while n < articles.length
        if articles[n].is_similar_to?(articles[-1])
          clusters[-1] << articles.delete_at(n)
        else
          n += 1
        end
      end
    end
    clusters
  end

end
