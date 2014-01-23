class TasksController < ApplicationController
helper_method :sort_column, :sort_direction

	def index
		#@tasks = current_user.tasks.paginate(page: params[:page])
		#@tasks = current_user.tasks.find_by(:done => false)

		#@tasks = Task.search(params[:search])
		@tasks = Task.search(params[:search]).order(sort_column + " " + sort_direction).paginate(page: params[:page])
	end

	def my_tasks
		#@tasks = current_user.tasks.order(id: :desc).paginate(page: params[:page])
		@tasks = current_user.tasks.search(params[:search]).order(sort_column + " " + sort_direction).paginate(page: params[:page])
		#tasks.paginate(page: params[:page])
	end

	def workspace
		#@tasks = current_user.tasks.where("due_date >= ? AND due_date <= ?", Time.now - 30.days, Time.now + 7.days).order(sort_column + " " + sort_direction).paginate(page: params[:page])
		@tasks = current_user.tasks.where("done = ? AND due_date <= ?", false,  Time.now + 7.days).order(sort_column + " " + sort_direction).paginate(page: params[:page])
	end

	def team_tasks
		@tasks = Task.joins(:user).where("senior = ?", current_user.id).search(params[:search]).order(sort_column + " " + sort_direction).paginate(page: params[:page])
	end

	def choose_task_set
		@customer = Customer.find(params[:customer_id])
		@task = Task.new
	end

	def apply_task_set
		@customer = Customer.find(params[:customer][:id])
		@task_set = TaskSet.find(params[:task_set][:id])

		if not params[:all_customers]
			@task_set.feeder_tasks.each do |sub|
				new_task = Task.new
					if sub.reference == "filing date" && @customer.next_target != nil
						calc_due = @customer.next_target + sub.offset.to_f.days
						new_task.update_attributes(name: sub.name, instructions: sub.instructions, reference: sub.reference, offset: sub.offset, csm_id: current_user.id, customer_id: @customer.id, due_date: calc_due)
						new_task.save
					elsif sub.reference == "start date" &&  @customer.start != nil
						calc_due = @customer.start + sub.offset.to_f.days
						new_task.update_attributes(name: sub.name, instructions: sub.instructions, reference: sub.reference, offset: sub.offset, csm_id: current_user.id, customer_id: @customer.id, due_date: calc_due)
						new_task.save
					end
			end
		else
			@customers = current_user.customers
			@customers.each do |cust|
				@task_set.feeder_tasks.each do |sub|
					new_task = Task.new
						if sub.reference == "filing date" && cust.next_target != nil
							calc_due = cust.next_target + sub.offset.to_f.days
							new_task.update_attributes(name: sub.name, instructions: sub.instructions, reference: sub.reference, offset: sub.offset, csm_id: current_user.id, customer_id: cust.id, due_date: calc_due)
							new_task.save
						elsif sub.reference == "start date" && cust.start != nil
							calc_due = cust.start + sub.offset.to_f.days
							new_task.update_attributes(name: sub.name, instructions: sub.instructions, reference: sub.reference, offset: sub.offset, csm_id: current_user.id, customer_id: cust.id, due_date: calc_due)
							new_task.save
						end
				end
			end
		end
		redirect_to @customer
	end

	def toggle_complete
	    @task = Task.find(params[:id])
	    @task.update_attribute(:done, true)
	    @task.save!
    	redirect_to (workspace_path)
	end
	def toggle_do
	    @task = Task.find(params[:id])
	    @task.update_attribute(:done, false)
	    @task.save!
    	redirect_to (workspace_path)
	end

	def show
		@task = Task.find(params[:id])
		if current_user?(User.find(@task.csm_id)) || current_user.admin?
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
		  #redirect_to @task
		  redirect_to workspace_path
		else
			render 'edit'
		end
	end

	def destroy
		#let(:tname) {User.find(params[:id]).name}
		Task.find(params[:id]).destroy
		flash[:success] = "Task deleted."
		redirect_to workspace_path
	end

	def create
	  	@task = Task.new(task_params)
	  	if @task.save
	  		flash[:success] = "Task Created"
	  		#redirect_to task_path(@task)
	  		redirect_to workspace_path
	  	else
	  		render 'new'
	  	end
	end

	private
		def task_params
	  		params.require(:task).permit(:name, :instructions, :csm_id, :customer_id, :due_date, :note)
	  	end

		def signed_in_user
	      unless signed_in?
	        store_location
	        redirect_to signin_url, notice: "Please sign in."
	      end
	    end
	    def sort_column
	    	Task.column_names.include?(params[:sort]) ? params[:sort] : "due_date"
	    end
	    def sort_direction
	    	%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
	    end

end
