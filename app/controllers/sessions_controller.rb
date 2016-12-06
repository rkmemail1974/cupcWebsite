class SessionsController < ApplicationController

	def new
		render 'new'
	end

	def create
		user = User.find_by_email(params[:session][:email])
		if user && user.authenticate(params[:session][:password])
			#sign user in and redirect to user's show page
		else
			flash[:error] = 'Invalid email/password combination' 
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_path
	end

end
