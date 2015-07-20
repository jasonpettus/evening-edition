require 'rails_helper'

RSpec.describe SectionsController, type: :controller do
  before :all do
    DatabaseCleaner.strategy = :transaction
  end

  before :each do
    DatabaseCleaner.start
    @section = FactoryGirl.create(:section, title: 'Default')
  end

  after :each do
    DatabaseCleaner.clean
  end

  describe '#show' do
    it 'when no user, it should render the default page' do
      get :show, {}, { user_id: nil }
      expect(page).to render('sections/default')
    end
  end
end
