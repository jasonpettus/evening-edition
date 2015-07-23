class SubscriptionsController < ApplicationController
	def new
		@subscription = Subscription.new
	end

	def create
		@section = Section.find_by(id: params[:section_id])
		@subscription = Subscription.new(subscription_params)
		begin
			@subscription.assign_attributes(section: @section, feed: Feed.find_or_create_by(feed_url: params['subscription']['feed']))
		rescue NoMethodError
			@subscription.assign_attributes(section: @section, feed: Feed.new)
		end
		if @subscription.save
			if request.xhr?
				render partial: 'subscriptions/subscription', locals: { section: @section, subscription: @subscription }
			else
				redirect_to sections_path
			end
		else
			if request.xhr?
				render json: @subscription.errors.full_messages
			else
				render "sections/index"
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
