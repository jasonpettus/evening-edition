class SectionsController < ApplicationController

  before_action :authorize_user_logged_in, except: :show
  def index
    @sections = current_user.sections
    @section = Section.new
    @page_name = "Edit Sections"
    @subscription = @section.subscriptions.new
    # @feed = Feed.new
  end

	def show
    if user_logged_in?
      @active_section = Section.find_by(id: params[:id]) || Section.find_by(title: 'Default')
      @sections = current_user.sections
    	@stories = @active_section.todays_stories
      @page_name = @active_section.title
      @stories = Kaminari.paginate_array(@stories).page(params[:page]).per(26)
      respond_to do |format|
        format.js { render text: "HELLO!"}
        format.html
      end
    else
      @section = Section.find_by(title: 'Default')
      # @stories = @section.todays_stories
      # @stories = @section.todays_stories.page(params[:page])
      # @stories = @section.todays_stories.limit(25).page(params[:page])
      @stories = Kaminari.paginate_array(@section.todays_stories).page(params[:page]).per(13)
      @page_name = "Top Stories"
      respond_to do |format|
        format.html
        format.js
      end
    end
	end

  def favorites
    @stories = Kaminari.paginate_array(current_user.favorited_stories).page(params[:page]).per(26)
    @page_name = "Saved Articles"
    render :show
  end

  #literally everything after here is subject to change based on the views

  def new
    @section = Section.new
  end

  def create
    @section = current_user.sections.build(section_params)
    @subscription = Subscription.new
    if @section.save
      if request.xhr?
        render partial: 'sections/section', locals: { section: @section }
      else
        redirect_to sections_path
      end
    else
      if request.xhr?
        redirect_to sections_path
      else
        redirect_to sections_path
      end
    end
  end

  def edit
    @sections = current_user.sections
    @section = Section.find(params[:id])
    @page_name = "Rename Section"
    if request.xhr?
      render :edit, layout: false
    end
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(section_params)
      if request.xhr?
        render nothing: true
      else
        redirect_to sections_url
      end
    else
      render :edit
    end
  end

  def destroy
    p 'DESTROY DESTROY'
    Section.find(params[:id]).destroy
    if request.xhr?
      render nothing: true
    else
      redirect_to :back
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
