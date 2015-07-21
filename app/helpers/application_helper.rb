module ApplicationHelper
  def user_logged_in?
      !session['user_id'].nil? && User.find_by(id: session['user_id'])
    end

    def current_user
      user_logged_in? ? User.find(session['user_id']) : nil
    end
end
