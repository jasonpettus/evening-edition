class ArticlesController < ApplicationController
	def show
		@section = Section.find_by(id: params[:section_id])
		@subscription = Subscription.find_by(id: params[:subscription_id])
		@article = Article.find_by(id: params[:id])
		# render "#{@article.summary}"
		respond_to do |format|
	    format.html { render :text => @article.summary }
	  end
	end
end
