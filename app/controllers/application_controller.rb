class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :reset_login_error

  private

    def reset_login_error
      session['login_error'] = false
    end

    def user_logged_in?
      !session['user_id'].nil?
    end

    def current_user
      user_logged_in? ? User.find(session['user_id']) : nil
    end

    def authorize_user_logged_in
      redirect_to root_path unless user_logged_in
    end
end
