class SectionsController < ApplicationController

  before_action :authorize_user_logged_in, except: :show

<<<<<<< Updated upstream
	def index
    if user_logged_in?
      redirect_to(user_url(current_user))
    else
    	@section = Section.find_by(title: 'Default')
      @stories = @section.stories
    end
	end

	def show
		@active_section = Section.find(params[:id])
    @sections = current_user.sections
		@stories = @section.stories
	end

=======
	def show
    if user_logged_in?
  		@active_section = Section.find(params[:id])
      @sections = current_user.sections
  		@stories = @section.stories
    else
      @section = Section.find_by(title: 'default')
      @stories = @section.stories
      render 'default'
    end
	end

>>>>>>> Stashed changes
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
      user_logged_in? ? current_user.sections.first : nil
    end
end
