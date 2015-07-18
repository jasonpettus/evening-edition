class SectionsController < ApplicationController

  before_action :authorize_user_logged_in, except: :index

	def index
    redirect_to :show if user_logged_in

  	@section = Section.find_by(title: :default)
    @stories = @section.stories
	end

	def show
		@section = Section.find_by(id: params[:id])
		@subscriptions = @section.subscriptions
	end
end
