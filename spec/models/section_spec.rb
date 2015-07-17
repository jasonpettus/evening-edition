require 'rails_helper'

RSpec.describe Section, :type => :model do
  describe '#stories' do
    it 'returns a list of articles'
    it 'clusters the articles so articles on the same story are grouped'
    it 'is ordered with most popular articles first'
  end
end
