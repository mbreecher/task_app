class TaskSetsController < ApplicationController
helper_method :sort_column, :sort_direction
before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
before_action :admin_user, only: [:index, :edit, :update, :destroy]

	def index
		@task_sets = TaskSet.order(sort_column + " " + sort_direction).paginate(page: params[:page])
	end

	def my_tasksets
		@task_sets = current_user.task_sets.order(sort_column + " " + sort_direction).paginate(page: params[:page])
	end

	def new
		@task_set = TaskSet.new
	end

	def show
		@task_set = TaskSet.find(params[:id])
		@feeder_tasks = FeederTask.where("task_set_id = ?", @task_set.id).order(sort_column + " " + sort_direction)
	end 

	def edit
		@task_set = TaskSet.find(params[:id])
	end

	def update
		@task_set = TaskSet.find(params[:id])
		if @task_set.update_attributes(task_set_params)
		  flash[:success] = "Task updated"
		  redirect_to @task_set
		else
			render 'edit'
		end
	end

	def destroy
		#let(:tname) {User.find(params[:id]).name}
		# delete feeders when orphaned
		@task_set = Taskset.find(params[:id])
		FeederTask.where("task_set_id = ?", @task_set_id).destroy
		TaskSet.find(params[:id]).destroy
		flash[:success] = "Task Set deleted."
		redirect_to my_tasksets_path
	end

	def create
	  	@task_set = TaskSet.new(task_set_params)
	  	if @task_set.save
	  		flash[:success] = "Task Set Created"
	  		#redirect_to customer_path(@customer)
	  		redirect_to my_tasksets_path
	  	else
	  		render 'new'
	  	end
	end
	private
		def signed_in_user
	      unless signed_in?
	        store_location
	        redirect_to signin_url, notice: "Please sign in."
	      end
	    end
		def task_set_params
	  		params.require(:task_set).permit(:name, :csm_id)
	  	end
	    def sort_column
	    	TaskSet.column_names.include?(params[:sort]) ? params[:sort] : "id"
	    end
	    def sort_direction
	    	%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
	    end
	    def admin_user
	      redirect_to(root_url) unless current_user.admin?
	    end
end
