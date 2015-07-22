class StoriesController < ApplicationController

  def update
    story = Story.find(params[:id])
    if story.update_attributes(favorited: params[:favorited])
      if request.xhr?
        render nothing: true
      else
        redirect_to :back
      end
    end
  end
end
