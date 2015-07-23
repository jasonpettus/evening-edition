require 'rails_helper'

RSpec.describe Section, :type => :model do

  before :all do
    DatabaseCleaner.strategy = :transaction
  end

  before :each do
    DatabaseCleaner.start
    @section = FactoryGirl.create(:section)
    populate_section(@section)
  end

  after :each do
    DatabaseCleaner.clean
  end

  describe '#stories' do
    pending 'returns a list of new stories' do
      expect(@section.stories).to all(satisfy { |story| story.has_key?('preferred')})
      expect(@section.stories).to all(satisfy { |story| story.has_key?('other_sources')})
      expect(@section.stories).to all(satisfy { |story| story.has_key?('size')})
    end

    # it 'clusters the articles so articles on the same story are grouped' do
    #   expect(@section.stories.length).to eq(3)
    #   expect(@section.stories).to contain_exactly( {preferred: @article1, other_stories: [@article1dup, @article1dubdup], size: 'big'},
    #                                                 {preferred: @article2, other_stories: [@article2dup], size: 'medium'},
    #                                                 {preferred: @article3, other_stories: [], size: 'small'})
    # end
    # it 'is ordered with most popular articles first'
  end

  def populate_section(section)
    allow_any_instance_of(Subscription).to receive(:get_articles).and_return(nil)
    allow_any_instance_of(Subscription).to receive(:save_articles).and_return(nil)
    @subscription1 = FactoryGirl.create(:subscription)
    @subscription2 = FactoryGirl.create(:subscription)
    @subscription3 = FactoryGirl.create(:subscription)
    @section.subscriptions.push(@subscription1, @subscription2, @subscription3)
    @article1 = FactoryGirl.create(:article)
    @article1dup = FactoryGirl.create(:article)
    @article1dubdup = FactoryGirl.create(:article)
    @article2 = FactoryGirl.create(:article_pluto)
    @article2dup = FactoryGirl.create(:article_pluto)
    @article3 = FactoryGirl.create(:article_british_open)
    @subscription1.articles.push(@article1, @article2)
    @subscription2.articles.push(@article1dup, @article3)
    @subscription3.articles.push(@article1dubdup, @article2dup)
  end
end
