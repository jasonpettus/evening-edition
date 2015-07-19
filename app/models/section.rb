class Section < ActiveRecord::Base
	has_many 	:subscriptions, dependent: :destroy
	belongs_to	:user
  has_many :articles, through: :subscriptions

	validates	:title, uniqueness: { scope: :user }


  def stories
    # Get all the articles
    # Check article similarity with other articles
    # Group by similarity
    stories = subscriptions.map { |subscription| subscription.recent_articles }
    story_clusters = cluster_articles(stories.flatten)
    stories_to_hash(story_clusters)
    # So we want to format things so the most important stories are first
    # We also want to point out the preferred article, so I guess we order the
    # clusters array with the longest length first, and order each cluster alphabetically
    # except with the preferred feeds first.
  end

  private
  def cluster_articles(articles)
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

  def stories_to_hash(cluster)
    cluster.map do |story_cluster|
      # sort story_cluster so preferred stories are first
      { 'preferred' => story_cluster[0], 'other_sources' => story_cluster[1..-1], 'size' => story_importance(story_cluster) }
    end
  end

  def story_importance(story_cluster)
    case story_cluster.length
    when 1
      # 'big'
      'splash'
    when 2..3
      'small'
    else
      'medium'
    end
  end
end
