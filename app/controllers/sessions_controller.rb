class SessionsController < ApplicationController

	def new
	end
	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			# sign in a redirect to user's show page
			sign_in user
			#redirect_back_or user
			redirect_back_or workspace_path
		else
			#create an error message and re-render the message form
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end
	def destroy
		sign_out
		redirect_to root_url
	end
end
