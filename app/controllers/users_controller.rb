class UsersController < ApplicationController
	require 'bcrypt'

	def new
		@user = User.new
	end

	def create

	end	
end
