class ArticlesController < ApplicationController
	def show
		@article = Article.find_by(id: params[:id])
		respond_to do |format|
	    format.html { render :text => @article.summary }
	  end
	end
end
