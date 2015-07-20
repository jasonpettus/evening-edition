class Section < ActiveRecord::Base
	has_many 	:subscriptions, dependent: :destroy
	belongs_to	:user
  has_many :articles, through: :subscriptions

	validates	:title, uniqueness: { scope: :user }


  def stories
    stories = subscriptions.map { |subscription| subscription.recent_articles }
    story_clusters = cluster_articles(stories.flatten)
    stories_to_hash(story_clusters)
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
    cluster = cluster.map do |story_cluster|
      # sort story_cluster so preferred stories are first
      { 'preferred' => story_cluster[0], 'other_sources' => story_cluster[1..-1], 'size' => story_importance(story_cluster) }
    end
    cluster.each do |story|
      if story['preferred'].img_link && story['preferred'].img_link != 'NONE'
        story['size'] = 'splash'
        break
      end
    end
    cluster
  end

  def story_importance(story_cluster)
    if story_cluster[0].img_link && story_cluster[0].img_link != 'NONE'
      %w(big medium splash small).sample
    else
      %w(medium small).sample
    end
    # case story_cluster.length
    # when 1
    #   'medium'
    # when 2..3
    #   'big'
    # else
    #   'splash'
    # end
  end
end
