class TasksController < ApplicationController

	def index
		#@tasks = current_user.customers.tasks.paginate(page: params[:page])

		@tasks = Task.paginate(page: params[:page])
	end
	def show
		if current_user?(User.find(params[:id])) || current_user.admin?
			@user = User.find(params[:id])
		else
	    	redirect_to(root_url)
		end
	end 

	def new
		@task = Task.new
	end

	def edit
	end

	private
		def customer_params
	  		params.require(:customer).permit(:name, :start, :fiscal_ye, :next_per_end, :next_target, :csm_id)
	  	end

		def signed_in_user
	      unless signed_in?
	        store_location
	        redirect_to signin_url, notice: "Please sign in."
	      end
	    end

end
