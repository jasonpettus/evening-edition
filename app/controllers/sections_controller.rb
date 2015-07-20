class SectionsController < ApplicationController

  before_action :authorize_user_logged_in, except: :show

	def show
    if user_logged_in?
    	@active_section = Section.find_by(id: params[:id]) || Section.find_by(title: 'Default')
    	@sections = current_user.sections
    	@stories = @active_section.stories
      render 'default' #remove this later
    else
      @section = Section.find_by(title: 'Default')
      @stories = @section.stories
      @page_name = "Top Stories"
      render 'default'
    end
	end

  #literally everything after here is subject to change based on the views

  def new
    @section = Section.new
  end

  def create
    @section = current_user.sections.build(section_params)
    if @section.save
      redirect_to :edit
    else
      render :new
    end
  end

  def edit
    @section = Section.find(params[:id])
    @subscriptions = @section.subscriptions
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attibutes(section_params)
      redirect_to @section
    else
      render :edit
    end
  end

  def delete
    Section.find(params[:id]).destroy
    redirect_to :show, id: user_default_section.id
  end

  private
    def section_params
      params.require(:sections).permit(:title)
    end

    def user_default_section
      user_logged_in? ? current_user.sections.first : nil
    end
end
