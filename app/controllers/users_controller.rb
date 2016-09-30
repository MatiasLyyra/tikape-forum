class UsersController < ApplicationController
	require 'bcrypt'
	
	def new
	end

	def create
	    if User.Validate?(user_params)
	    	password_salt = BCrypt::Engine.generate_salt
	    	password = BCrypt::Engine.hash_secret(user_params[:password], password_salt)
	    	User.CreateUser(user_params[:nick], password, password_salt).first
	    	#Whoa, used ActiveRecords find_by here, please don't crucify me. find_by_sql bugged for some reason here 4/5 times
	    	@user = User.find_by(nick: user_params[:nick])
			redirect_to @user
	    else
			if not User.GetUserByNick(user_params[:nick]).nil?
				flash[:notice] = 'Nick is already taken'
			else
				flash[:notice] = 'Invalid form'
			end
			redirect_to :back
	    end
	    
	end

	def show
		@user = User.GetUserById(params[:id])
	end

	private 
	def user_params
		params.require(:user).permit(:nick, :password, :password_confirmation)
	end
end
