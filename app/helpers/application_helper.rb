module ApplicationHelper
  def user_logged_in?
      !session['user_id'].nil?
    end

    def current_user
      user_logged_in ? nil : User.find(session['user_id'])
    end
end
