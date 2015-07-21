class Section < ActiveRecord::Base
	belongs_to	:user
  has_many  :subscriptions, dependent: :destroy
  has_many :stories
  has_many :articles, through: :subscriptions

	validates	:title, uniqueness: { scope: :user }



  def cluster_similar_stories
    todays_articles = articles.where("articles.created_at > now() - interval '1 day'")
    clusters = cluster_articles(todays_articles)
    todays_stories = clusters_to_stories(clusters)
  end

  def todays_stories
    recent_stories = stories.where("stories.updated_at > now() - interval '1 day'").order("stories.id DESC").limit(14)
    assign_sizes(order_stories(recent_stories))
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

  def clusters_to_stories(clusters)
    story_clusters = clusters.map do |story_cluster|
      # sort story_cluster so preferred stories are first
      stories.create(preferred_story: story_cluster[0], articles: story_cluster)
    end
    get_imgs(story_clusters)
    assign_sizes(ordered_stories(story_cluster))
    # Split stories into groups with images and without images
    # build an array of size groups out of those
    # shuffle then flatten?

    # So we kind of have a chicken//egg scenario here. Being able to grab images informs the size of stories
    # but at the same time grabbing images takes really long so being able to figure out the sizes of stories
    # first would speed that up

  end

  def get_imgs(story_cluster)
    number_of_images_needed = ((3 * story_cluster.length) / 13) + partial_patten_offset
    story_cluster.each do |story|
      story.fetch_img
      if story.has_image?
        number_of_images_needed -= 1
      end
      break if number_of_images_needed == 0
    end
  end

  def order_stories(story_cluster)
    with_img = story_cluster.select { |story| story.has_image? }
    without_img = story_cluster.reject { |story| story.has_image? }

    ordered_stories = Array.new(story_cluster.length)
    ordered_stories.each_with_index do |story, i|
      if (i % 13 == 0 || i % 13 == 4 || i % 13 == 8) && !with_img.empty?
        ordered_stories[i] = with_img.pop
      else
        ordered_stories[i] = without_img.pop
      end
    end
    ordered_stories
  end

  def assign_sizes(ordered_stories)
    ordered_stories.each_with_index do |story, i|
      case i % 13
      when 0
        story.size = "splash"
      when 4, 8
        story.size = "big"
      when 1, 2, 3, 7, 11, 12
        story.size = "medium"
      else
        story.size = "small"
      end
      story.save
    end
  end

  def partial_patten_offset
    case stories.length % 13
    when 0,1,2,3
      1
    when 4,5,6,7
      2
    else
      3
    end
  end
end
