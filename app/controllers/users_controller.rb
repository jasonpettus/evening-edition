class UsersController < ApplicationController

  def login
    user = User.find_by(email: params['email'])
    if user && user.authenticate(params['password'])
      login_user(user)
      session['login_error'] = false
    else
      session['login_error'] = true
    end

    if request.xhr?
      render partial: 'application/masthead'
    else
      redirect_to :back
    end
  end

  def logout
    logout_user
    redirect_to :back
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user(@user)
      session['creation_error'] = false
      redirect_to sections_path
    else
      @page_name = "Create Account"
      session['creation_error'] = false
      render 'new'
    end
  end

  def new
    @user = User.new
    @page_name = "Create Account"
    if request.xhr?
      render partial: "users/user_form", locals: { user: @user }
    end
  end

  def show
    @user = current_user
    @sections = @user.sections
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def login_user(user)
      session['user_id'] = user.id
    end

    def logout_user
      session['user_id'] = nil
    end
end
