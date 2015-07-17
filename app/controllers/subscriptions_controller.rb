class SubscriptionsController < ApplicationController
	def show
		@section = Section.find_by(id: params[:section_id])
		@subscription = Subscription.find_by(id: params[:id])
		@articles = @subscription.articles
	end
end
