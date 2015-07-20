require 'rails_helper'

RSpec.describe Article, :type => :model do

  before :all do
    DatabaseCleaner.strategy = :transaction
  end

  before :each do
    DatabaseCleaner.start
    @article = FactoryGirl.create(:article, title: 'Letting Our Emojis Get in the Way')
  end

  after :each do
    DatabaseCleaner.clean
  end

  describe '#is_similar_to?' do

    it 'should be similar to itself' do
      expect(@article.is_similar_to?(@article)).to be(true)
    end

    pending 'should be similar to articles on the same story' do
      titles = ['Letting Emojis Get in our Way',
                'We Are Letting Emojis Get in our Way',
                'Are Our Emojis Getting in our way?']
      titles.each do |title|
        expect(@article.is_similar_to?(FactoryGirl.create(:article, title: title))).to be(true)
      end
    end

    it 'should not be similar to articles on different stories' do
      titles = ['Pepsi Celebrates World Emoji Day With More Emoji',
                'Cats make the best pets, Bono says',
                'Emoji Aren\'t Silly—They Could Actually Help the Deaf']
      titles.each do |title|
        expect(@article.is_similar_to?(FactoryGirl.create(:article, title: title))).to be(false)
      end
    end
  end
end
