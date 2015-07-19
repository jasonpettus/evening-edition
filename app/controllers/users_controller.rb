class UsersController < ApplicationController

  def login
    user = User.find_by(email: params['email'])
    if user.authenticate(params['password'])
      login_user(user)
      redirect_to :back
    else
      session['login_error'] = true
      render :back
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
      redirect_to new_section_path
    else
      render 'new'
    end
  end

  def new
    @user = User.new
  end

  def show
    @user = current_user
    @sections = @user.sections
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end

    def login_user(user)
      session['user_id'] = user.id
    end

    def logout_user
      session['user_id'] = nil
    end
end
