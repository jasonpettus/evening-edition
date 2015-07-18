class UsersController < ApplicationController

  def login
    user = User.find_by(username: params['username'])
    if user.authenticate(params['password'])
      login_user(user)
      redirect_to :back
    else
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
      redirect_to root_path
    else
      render 'new'
    end
  end

  def new
    @user = User.new
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
