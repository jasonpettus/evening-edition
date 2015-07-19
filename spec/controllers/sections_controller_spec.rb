require 'rails_helper'

RSpec.describe SectionsController, type: :controller do
  describe '#show' do
    it 'when no user, it should render the default page' do
      get :show, {}, { user_id: nil }
      expect(page).to render('sections/default')
    end
  end
end
