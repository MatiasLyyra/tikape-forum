class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	helper_method :current_user

	def current_user
		return nil unless session[:user_id]
		User.GetUserById session[:user_id]
	end
end
