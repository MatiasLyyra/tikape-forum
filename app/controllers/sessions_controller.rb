class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.GetUserByNick(params[:nick])
    if user and User.Authenticate(params[:nick], params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user), notice: "Successfully logged in!"
    else
      redirect_to :back, notice: "Password or nick did not match"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end