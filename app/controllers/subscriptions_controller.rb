class SubscriptionsController < ApplicationController
	def new 
		@subscription = Subscription.new
	end

	def create
		@section = Section.find_by(id: params[:section_id])
		@subscription = Subscription.create(params[subscription_params], section: @section)

		if @subscription.valid?
			redirect_to :back
		end
	end

	def delete
		Subscription.find_by(id: params[:id]).destroy
	end

	private
		def subscription_params
			params.require(:subscription).permit(:feed_url, :name)
		end
end
