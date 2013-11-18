class CustomersController < ApplicationController
	before_action :signed_in_user, only: [:index, :edit, :update, :destroy]

	def index
		@customers = Customer.paginate(page: params[:page])
	end

	def show
		@customer = Customer.find(params[:id])
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
		  redirect_to @customer
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
