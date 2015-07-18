class SectionsController < ApplicationController

  before_action :authorize_user_logged_in, except: :index

	def index
    redirect_to(:show, id: user_default_section.id) if user_logged_in

  	@section = Section.find_by(title: :default)
    @stories = @section.stories
	end

	def show
    redirect_to(:show, id: user_default_section.id) unless current_user.sections.include?(Section.find(params[:id]))

		@active_section = Section.find(params[:id])
    @sections = current_user.sections
		@stories = @section.stories
	end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attibutes(section_params)
      redirect_to :show, id: @section.id
    else
      render :edit
    end
  end

  def delete
    Section.find(params[:id]).destroy
    redirect_to :show, id: user_default_section.id
  end

  def new
    @section = Section.new
  end

  def create
    @section = current_user.sections.build(section_params)
    if @section.save
      redirect_to :show, id: @section.id
    else
      render :new
    end
  end

  private
    def section_params
      params.require(:sections).permit(:title)
    end

    def user_default_section
      user_logged_in ? current_user.sections.first : nil
    end
end
