class StoriesController < ApplicationController

  def update
    story = Story.find(params[:id])
    if story.update_attributes(params[:favorite])
      if request.xhr?
        render nothing:true
      else
        redirect_to :back
      end
    end
  end
end
