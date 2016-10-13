module UsersHelper
  def is_current_user_admin?
    current_user = get_current_user
    if current_user.nil?
      return false
    else
      return current_user.admin
    end
  end

  def is_user_logged_in?
    return session[:user_id] != nil
  end

  def get_current_user
    return User.GetUserById(session[:user_id])
  end
end
