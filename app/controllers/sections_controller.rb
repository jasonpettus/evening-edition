class SectionsController < ApplicationController

  before_action :authorize_user_logged_in, except: :show
  def index
    @sections = current_user.sections
    @section = Section.new
    @page_name = "Edit Sections"
  end

	def show
    if user_logged_in?
      @active_section = Section.find_by(id: params[:id]) || Section.find_by(title: 'Default')
      @sections = current_user.sections
    	@stories = @active_section.todays_stories
      @page_name = @active_section.title
      respond_to do |format|
        format.js { render text: "hi Leon"}
        format.html
      end

      # @page_name = @active_section.title
      @page_name = "Top Stories"
      @stories = Kaminari.paginate_array(@stories).page(params[:page]).per(25)
      # render 'default' #remove this later
    else
      @section = Section.find_by(title: 'Default')
      # @stories = @section.todays_stories
      # @stories = @section.todays_stories.page(params[:page])
      # @stories = @section.todays_stories.limit(25).page(params[:page])
      @stories = Kaminari.paginate_array(@section.todays_stories).page(params[:page]).per(5)
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
    @sections = current_user.sections
    @section = Section.find(params[:id])
    @page_name = "Rename Section"
    @subscriptions = @section.subscriptions
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(section_params)
      redirect_to sections_url
    else
      render :edit
    end
  end

  def destroy
    Section.find(params[:id]).destroy
    redirect_to :back
  end

  def new
    @section = Section.new
    redirect_to root_path #remove this later
  end

  def create
    @section = current_user.sections.build(section_params)
    if @section.save
      redirect_to :back
    else
      render :new
    end
  end

  private
    def section_params
      params.require(:section).permit(:title)
    end

    def user_default_section
      user_logged_in? ? current_user.sections.first : nil
    end
end
