class TasksController < ApplicationController

	def index
		@tasks = current_user.tasks.paginate(page: params[:page])

		#@tasks = Task.paginate(page: params[:page])
	end
	def show
		if current_user?(User.find(params[:id])) || current_user.admin?
			@task = Task.find(params[:id])
		else
	    	redirect_to(root_url)
		end
	end 

	def new
		@task = Task.new
	end

	def edit
		@task = Task.find(params[:id])
	end

	def update
		@task = Task.find(params[:id])
		if @task.update_attributes(task_params)
		  #handle a successful update
		  flash[:success] = "Task updated"
		  redirect_to @task
		else
			render 'edit'
		end
	end

	def destroy
		#let(:tname) {User.find(params[:id]).name}
		Task.find(params[:id]).destroy
		flash[:success] = "Customer deleted."
		redirect_to tasks_url
	end

	def create
	  	@task = Task.new(task_params)
	  	if @task.save
	  		flash[:success] = "Task Created"
	  		redirect_to task_path(@task)
	  	else
	  		render 'new'
	  	end
	end

	private
		def task_params
	  		params.require(:task).permit(:name, :instructions, :csm_id, :customer_id, :due_date)
	  	end

		def signed_in_user
	      unless signed_in?
	        store_location
	        redirect_to signin_url, notice: "Please sign in."
	      end
	    end

end
