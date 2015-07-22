namespace :update do

  task :feeds => :environment do
    Feed.all.each do |feed|
      begin
        feed.get_articles
      rescue
      end
    end
    Section.all.each{ |section| section.cluster_similar_stories }
  end
end
