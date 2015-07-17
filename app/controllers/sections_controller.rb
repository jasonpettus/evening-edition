class SectionsController < ApplicationController
	def index
		@sections = Section.all
	end

	def show
		@section = Section.find_by(id: params[:id])
		@subscriptions = @section.subscriptions
	end
end
