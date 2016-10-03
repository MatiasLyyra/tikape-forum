module UsersHelper
  def is_current_user_admin?
    current_user = User.GetUserById(session[:user_id])
    if current_user.nil?
      return false
    else
      return current_user.admin
    end
  end

  def is_user_logged_in?
    return (not session[:user_id].nil?)
  end
end
