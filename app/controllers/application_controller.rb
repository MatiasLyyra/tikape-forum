class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def authenticate_user
    if session[:user_id]
      @current_user = User.GetUserById(session[:user_id])
      return true
    else
      redirect_to signin_path
      return false
    end
  end

  def save_login_state
    if session[:user_id]
      redirect_to_back_or_root 'You are already logged in'
      return false
    else
      return true
    end
  end

  def authenticate_admin
    @current_user = User.GetUserById(session[:user_id])
    if @current_user.nil? 
      redirect_to_back_or_root 'You do not have permission for this'
      return false
    else
      redirect_to_back_or_root 'You do not have permission for this' unless @current_user.admin
      return @current_user.admin
    end
  end

  def redirect_to_back_or_root(notice = '')
    begin
      redirect_to :back, notice: notice
    rescue ActionController::RedirectBackError
      redirect_to :root, notice: notice
    end
  end
end
  