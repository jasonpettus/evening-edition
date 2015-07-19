class Section < ActiveRecord::Base
	has_many 	:subscriptions, dependent: :destroy
	belongs_to	:user
  has_many :articles, through: :subscriptions

	validates	:title, uniqueness: { scope: :user }


  def stories
    # Get all the articles
    # Check article similarity with other articles
    # Group by similarity
    story_clusters = cluster_articles(articles)
    stories_to_hash(story_clusters)
    # So we want to format things so the most important stories are first
    # We also want to point out the preferred article, so I guess we order the
    # clusters array with the longest length first, and order each cluster alphabetically
    # except with the preferred feeds first.
  end

  private
  def cluster_articles(articles)
    articles = articles.order('id').map { |x| x }
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

  def stories_to_hash(cluster)
    cluster.map do |story_cluster|
      # sort story_cluster so preferred stories are first
      { preferred: story_cluster[0], other_stories: story_cluster[1..-1], size: 'medium' }
    end
  end
end
