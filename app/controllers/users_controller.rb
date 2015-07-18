class UsersController < ApplicationController

  def login
  end

  def logout
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
      params.require(:user).permit(:username, :password)
    end

    def login_user(user)
      session[user_id] = user.id
    end

    def logout_user
      session[user_id] = nil
    end
end
