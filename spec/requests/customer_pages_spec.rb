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
        				expect(page).to have_selector('li', text: customer.name)
        			end
        		end

        		it "should have edit but not delete links" do
        			#save_and_open_page
        			page.should_not have_link('delete')
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
        				expect(page).to have_selector('li', text: customer.name)
        			end
        		end

        		it "should have control links" do
        			page.should have_link('delete')
        			page.should have_link('edit')
        		end

        		it "should be able to delete a customer" do
		          expect do
		            click_link('delete', match: :first)
		          end.to change(Customer, :count).by(-1)
		        end
        	end
		end
	end
	describe "edit customers page" do
	end

end