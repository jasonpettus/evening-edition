class SubscriptionsController < ApplicationController
	def new
		@subscription = Subscription.new
	end

	def create
		p params
		@section = Section.find_by(id: params[:section_id])
		@subscription = Subscription.create(subscription_params)
		@subscription.update_attributes(section: @section, feed: Feed.first_or_create(feed_url: params['subscription']['feed']))
		if @subscription.valid?
			redirect_to :back
		end
	end

	def destroy
		Subscription.find_by(id: params[:id]).destroy
		redirect_to :back
	end

	private
		def subscription_params
			params.require(:subscription).permit(:name)
		end
end
