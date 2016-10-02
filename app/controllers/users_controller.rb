class UsersController < ApplicationController
  require 'bcrypt'
  before_action :set_user, only:[:show, :edit, :update]
  before_action :save_login_state, only: [:new, :create]
  before_action :authenticate_user, only: [:edit, :update]
  before_action :check_if_current_user, only: [:edit, :update]
  before_action :authenticate_admin, only: [:list]
  
  def new
  end

  def list
    @all_users = User.find_by_sql("SELECT * FROM User")
  end

  def create
    if User.Validate?(user_params)
      password_salt = BCrypt::Engine.generate_salt
      password = BCrypt::Engine.hash_secret(user_params[:password], password_salt)
      User.CreateUser(user_params[:nick], password, password_salt).first
      #Whoa, used ActiveRecords find_by here, please don't crucify me. find_by_sql bugged for some reason here 4/5 times
      @user = User.find_by(nick: user_params[:nick])
      redirect_to signin_path(nick: @user.nick)
    else
      if not User.GetUserByNick(user_params[:nick]).nil?
        flash[:notice] = 'Nick is already taken'
      else
        flash[:notice] = 'Invalid form'
      end
      redirect_to :back
    end
  end

  def edit
  end

  def update
    nick_empty = user_params[:nick].empty?
    password_empty = user_params[:password].empty?
    admin = user_params[:admin] or false
    nick_valid = nick_empty || User.ValidateNick(user_params[:nick])
    password_valid = password_empty || User.ValidatePassword(user_params[:password], user_params[:password_confirmation])
    if nick_valid and password_valid and User.Authenticate(@current_user.nick, user_params[:old_password])
      @user.updateNick(user_params[:nick]) unless nick_empty
      @user.updatePassword(user_params[:password]) unless password_empty
      @user.changeAdminStatus(admin) if @current_user.admin?
      redirect_to @user
    else
      if not nick_valid
        flash[:notice] = 'Nick is already taken or it is too short'
      else
        flash[:notice] = 'Passwords did not match or the current password was wrong'
      end
      redirect_to :back
    end
  end

  def show
  end

  private 
  def set_user
    @user = User.GetUserById(params[:id])
  end

  def user_params
    # List of common params
    list_params_allowed = [:nick, :password, :password_confirmation, :old_password]
    # Add the params only for admin
    unless @current_user.nil?
      list_params_allowed << :admin if @current_user.admin?
    end
    params.require(:user).permit(list_params_allowed)
  end

  def check_if_current_user
    if @current_user && (session[:user_id] == params[:id].to_i || @current_user.admin)
      return true
    else
      redirect_to_back_or_root 'You can not change other users'
      return false
    end
  end
end
