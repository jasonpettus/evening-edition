require 'rails_helper'

RSpec.describe Article, :type => :model do

  before :all do
    DatabaseCleaner.strategy = :transaction
  end

  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end

  describe '#is_similar_to?' do
    it 'should be similar to itself' do
      article = FactoryGirl.create(:article)
      expect()
    end
    it 'should be similar to articles on the same story'
    it 'should not be similar to articles on different stories'
  end
end
