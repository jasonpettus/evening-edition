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
      puts ">" * 50
      p @active_section
      puts ">" * 50
      @sections = current_user.sections
    	@stories = @active_section.todays_stories
      @page_name = @active_section.title
      @stories = Kaminari.paginate_array(@stories).page(params[:page]).per(25)
      if @active_section.stories.empty?
        @active_section.cluster_similar_stories
      end
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

  #literally everything after here is subject to change based on the views

  def new
    @section = Section.new
  end

  def create
    @section = current_user.sections << Section.create(section_params)
    @subscription = Subscription.new
    if @section.valid?
      if request.xhr?
        render partial: 'sections/section', locals: { section: @section }
      else
        redirect_to :index
      end
    else
      if request.xhr?
        redirect_to :index
      else
        redirect_to :index
      end
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

  private
    def section_params
      params.require(:section).permit(:title)
    end

    def user_default_section
      user_logged_in? ? current_user.sections.first : nil
    end
end
