class SessionsController < ApplicationController
  before_action :save_login_state, only: [:new, :create]

  def new
  end

  def create
    user = User.GetUserByNick(params[:nick])
    if user and User.Authenticate(params[:nick], params[:password])
      session[:user_id] = user.id
      #user.newLogin
      redirect_to :root, notice: "Successfully logged in!"
    else
      redirect_to_back_or_root alert: "Password or nick did not match"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end