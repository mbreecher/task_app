require 'spec_helper'

describe "Task Pages" do 
	subject {page}

	describe "index" do

		describe "admin user" do
			let(:admin) {FactoryGirl.create(:admin)}
			let(:task) {FactoryGirl.create(:task)}

			before do
				sign_in admin
				visit tasks_path
			end

			it {should have_title('Tasks')}
		end
	end
end