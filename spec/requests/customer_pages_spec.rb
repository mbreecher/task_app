require 'spec_helper'

describe "Customer Pages"  do
	subject {page}

	describe "index" do
		describe "non-admin user" do
			let(:user) {FactoryGirl.create(:user)}
			let(:customer) {FactoryGirl.create(:customer)}
			before(:each) do
				sign_in user
				visit customers_path
			end 

			it {should have_title('All customers')}
			it {should have_link('Customers')}

			describe "pagination" do

				before (:all) {35.times { FactoryGirl.create(:customer)}}
        		after(:all) {Customer.delete_all}

        		it {should have_selector('div.pagination')}

        		it "should list each customer" do
        			Customer.paginate(page: 1).each do |customer|
        				expect(page).to have_selector('tr', text: customer.name)
        			end
        		end

        		it "should only have edit link" do
        			#save_and_open_page
        			page.should_not have_link('delete')
        			page.should_not have_link('Create New Customer')
        			page.should have_link('edit')
        		end
        	end
		end
		describe "admin user" do
			let(:admin) {FactoryGirl.create(:admin)}
			let(:customer) {FactoryGirl.create(:customer)}
			before(:each) do
				sign_in admin
				visit customers_path
			end 

			describe "pagination" do

				before (:all) {35.times { FactoryGirl.create(:customer)}}
        		after(:all) {Customer.delete_all}

        		it {should have_selector('div.pagination')}

        		it "should list each customer" do
        			Customer.paginate(page: 1).each do |customer|
        				expect(page).to have_selector('tr', text: customer.name)
        			end
        		end

        		it "should have control links" do
        			page.should have_link('delete')
        			page.should have_link('edit')
        			page.should have_link('Create New Customer')
        		end

        		it "should be able to delete a customer" do
		          expect do
		            click_link('delete', match: :first)
		          end.to change(Customer, :count).by(-1)
		        end
        	end
		end
	end
	describe "profile page" do
	  	let(:user) {FactoryGirl.create(:user)}
	  	let(:customer) {FactoryGirl.create(:customer)}
	  	before do 
	  		sign_in user
	      	visit customer_path(customer)
	    end

	    it "should have named content and title" do
	    	#save_and_open_page
		  	page.should have_content(customer.name)
		    page.should have_title(full_title(customer.name))
		end
	end

	describe "New Customer Page" do
	    let(:user) {FactoryGirl.create(:user)}

	    before (:each) do
	    	sign_in user
	    	visit new_customer_path
	    end

	    let(:submit) {"Create Customer"}

	    describe "with invalid information" do
	      it "should not create a user" do
	        expect {click_button submit}.not_to change(Customer, :count)
	      end
	      describe "after submission" do
	        before {click_button submit}

	        it {should have_title('New Customer')}
	        it {should have_content ('error')}
	      end
	    end

	    describe "with valid information" do
		    before do
		      fill_in "Name",           with: "Example Company"
		      fill_in "Start Date",          with: "2013/11/18"
		    end

		    describe "after saving the customer" do
		      before {click_button submit}
		      let(:customer) {Customer.find_by(name: 'Example Company')}

		      it "should create a customer" do
		      	#save_and_open_page
		      	page.should have_title(customer.name)
		      	page.should have_selector('div.alert.alert-success', text: 'Customer Created')
		      end
		    end 
		    it "should create a user" do
		      expect {click_button submit}.to change(Customer, :count).by(1)
		    end
		end
	end 

	describe "edit customers page" do
		let(:user) {FactoryGirl.create(:user)}
	  	let(:customer) {FactoryGirl.create(:customer)}
	  	before do 
	  		sign_in user
	      	visit edit_customer_path(customer)
	    end

	    it "should have named content and title" do
	    	#save_and_open_page
		  	page.should have_content(customer.name)
		    page.should have_title(full_title("Edit customer"))
		end
		describe "with valid information" do
			let(:new_name){"New Name"}
			let(:new_date){"2013/12/31"}
			before do
		      fill_in "Name",           		with: new_name
		      fill_in "Fiscal Year End Date",   with: new_date
		      click_button "Save changes"
		    end

		   	it {should have_title(new_name)}
		    it {should have_selector('div.alert.alert-success')}
		    specify { expect(customer.reload.name).to eq new_name}
		    #specify { expect(customer.reload.fiscal_ye).should be_within(1).of(new_date)}
	    end
	end
end