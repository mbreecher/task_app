class TasksController < ApplicationController

	def index
		#@tasks = current_user.tasks.paginate(page: params[:page])
		#@tasks = current_user.tasks.find_by(:done => false)

		@tasks = Task.paginate(page: params[:page])
	end

	def my_tasks
		@tasks = current_user.tasks.paginate(page: params[:page])
		#tasks.paginate(page: params[:page])
	end

	def workspace
		@tasks = current_user.tasks.where(done: false).paginate(page: params[:page])
		#@tasks = current_user.tasks.paginate(page: params[:page])
	end

	def completed
	    @task = Task.find(params[:id])
	    @task.toggle!(:done)
	    @task.save
	    #flash[:success] = "Task completed"
    	#redirect_to(tasks_path)
    	redirect_to :back
    rescue ApplicationController::RedirectBackError
    	redirect_to(tasks_path)
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