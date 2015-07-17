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


end
