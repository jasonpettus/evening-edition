class Section < ActiveRecord::Base
	belongs_to	:user
  has_many  :subscriptions, dependent: :destroy
  has_many :stories, through: :user
  has_many :articles, through: :subscriptions

	validates	:title, uniqueness: { scope: :user }



  def cluster_similar_stories
    todays_articles = articles.where("created_at > now() - interval '1 day'")
    clusters = cluster_articles(todays_stories)
    todays_stories = clusters_to_stories(clusters)
    todays_stories.each {|story| story.fetch_img if story.size == 'big' || story.size == 'splash' }
  end

  # def stories
  #   stories = subscriptions.map { |subscription| subscription.recent_articles }
  #   story_clusters = cluster_articles(stories.flatten)
  #   stories_to_hash(story_clusters)
  # end

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

  def clusters_to_stories(clusters)
    stories = cluster.map do |story_cluster|
      # sort story_cluster so preferred stories are first
      stories.build(top_story: story_cluster[0], articles: story_cluster, size: 'medium')
    end

    # Split stories into groups with images and without images
    # build an array of size groups out of those
    # shuffle then flatten?

    # So we kind of have a chicken//egg scenario here. Being able to grab images informs the size of stories
    # but at the same time grabbing images takes really long so being able to figure out the sizes of stories
    # first would speed that up

  end

  def random_story_importance(story_cluster)
    if story_cluster[0].has_image?
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
