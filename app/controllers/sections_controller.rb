class SectionsController < ApplicationController

  before_action :authorize_user_logged_in, except: :index

	def index
    redirect_to(:show, id: user_default_section.id) if user_logged_in

  	@section = Section.find_by(title: :default)
    @stories = @section.stories
	end

	def show
    redirect_to(:show, id: user_default_section.id) unless current_user.sections.include?(Section.find(params[:id]))

		@active_section = Section.find_by(id: params[:id])
    @sections = current_user.sections
		@stories = @section.stories
	end

  def edit
  end

  def update
  end

  def delete
  end

  def new
  end

  private
    def user_default_section
      user_logged_in ? current_user.sections.first : nil
    end
end
