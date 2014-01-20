class CustomersController < ApplicationController
helper_method :sort_column, :sort_direction
before_action :signed_in_user, only: [:index, :edit, :update, :destroy]

	def index
		@customers = Customer.search(params[:search]).order(sort_column + " " + sort_direction).paginate(page: params[:page])
	end

	def accounts
		#@customers = current_user.customers.joins(:user, :customer).order(sort_column + " " + sort_direction).paginate(page: params[:page])
		@customers = current_user.customers.search(params[:search]).order(sort_column + " " + sort_direction).paginate(page: params[:page])
	end

	def team_customers
		@customers = Customer.joins(:user).where("senior = ?", current_user.id).search(params[:search]).order(sort_column + " " + sort_direction).paginate(page: params[:page])
	end

	def show
		@customer = Customer.find(params[:id])
		@tasks = Task.where("customer_id = ?", @customer.id).order(sort_column + " " + sort_direction)
	end

	def new
		@customer = Customer.new
	end

	def edit
		@customer = Customer.find(params[:id])
	end

	def update
		@customer = Customer.find(params[:id])
		if @customer.update_attributes(customer_params)
		  #handle a successful update
		  flash[:success] = "Customer updated"
		  #redirect_to @customer
		  redirect_to accounts_path
		else
			render 'edit'
		end
	end

	def destroy
		#let(:tname) {User.find(params[:id]).name}
		Customer.find(params[:id]).destroy
		flash[:success] = "Customer deleted."
		redirect_to customers_url
	end

	def create
	  	@customer = Customer.new(customer_params)
	  	if @customer.save
	  		flash[:success] = "Customer Created"
	  		#redirect_to customer_path(@customer)
	  		redirect_to accounts_path
	  	else
	  		render 'new'
	  	end
	end

	private
		def customer_params
	  		params.require(:customer).permit(:name, :start, :fiscal_ye, :next_per_end, :next_target, :csm_id, :single_source, :note, :xbrl_service)
	  	end

		def signed_in_user
	      unless signed_in?
	        store_location
	        redirect_to signin_url, notice: "Please sign in."
	      end
	    end
	    def sort_column
	    	Customer.column_names.include?(params[:sort]) ? params[:sort] : "name"
	    end
	    def sort_direction
	    	%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
	    end
end
