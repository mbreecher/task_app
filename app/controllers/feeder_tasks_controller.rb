class FeederTasksController < ApplicationController
helper_method :sort_column, :sort_direction
before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
before_action :admin_user, only: [:index, :edit, :update, :destroy]

def index
	@feeder_tasks = FeederTask.order(sort_column + " " + sort_direction)
end

def new
	@feeder_task = FeederTask.new
	@task_set = TaskSet.find(params[:task_set_id])
end

def edit
	@feeder_task = FeederTask.find(params[:id])
end

def update
	@feeder_task = FeederTask.find(params[:id])
	if @feeder_task.update_attributes(feeder_task_params)
	  flash[:success] = "Sub task updated"
	  redirect_to task_set_path(@feeder_task.task_set_id)
	else
		render 'edit'
	end
end

def destroy
	@feeder_task = FeederTask.find(params[:id])
	#let(:tname) {User.find(params[:id]).name}
	FeederTask.find(params[:id]).destroy
	flash[:success] = "Task Set deleted."
	redirect_to task_set_path(@feeder_task.task_set_id)
end

def create
  	@feeder_task = FeederTask.new(feeder_task_params)
  	if @feeder_task.save
  		flash[:success] = "Sub Task Added"
  		#redirect_to customer_path(@customer)
  		redirect_to task_set_path(@feeder_task.task_set)
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
		def feeder_task_params
	  		params.require(:feeder_task).permit(:name, :reference, :offset, :task_set_id)
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
