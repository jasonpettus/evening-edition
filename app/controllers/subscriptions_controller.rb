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
			if request.xhr?
				render partial: 'subscriptions/subscription', locals: { section: @section, subscription: @subscription }
			else
				redirect_to section_path(@section)
			end
		end
	end

	def edit
		@subscription = Subscription.find(params[:id])
		if request.xhr?
			render partial: 'subscriptions/edit_form', locals: { subscription: @subscription }
		else
		end
	end

	def update
		@subscription = Subscription.find(params[:id])
		@subscription.update_attributes(subscription_params)
		if @subscription.valid?
			if request.xhr?
				render nothing: true
			end
		end
	end

	def destroy
		Subscription.find_by(id: params[:id]).destroy
		if request.xhr?
			render nothing: true
		else
		redirect_to :back
		end
	end

	private
		def subscription_params
			params.require(:subscription).permit(:name)
		end
end
