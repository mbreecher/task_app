FactoryGirl.define do
	factory :user do
		sequence(:name) {|n| "Person #{n}"}
		sequence(:email) { |n| "person_test_#{n}@webfilings.com"}
		password	"foobar800"
		password_confirmation	"foobar800"

		factory :admin do
			admin true
		end
	end
end

FactoryGirl.define do
	factory :customer do
		sequence(:name) {|n| "Company #{n}"}
		start Date.new(2010,1,1)
		fiscal_ye Date.new(2013,12,31)
		next_per_end Date.new(2013, 12, 31)
		next_target Date.new(2014, 2, 15)
	end
end

FactoryGirl.define do
	factory :task do
		sequence(:name) {|n| "Task #{n}"}
		due_date Date.new(2013,12,1)
	end
end

FactoryGirl.define do
	factory :task_set do
		sequence(:name) {|n| "Task Set #{n}"}
	end
end

FactoryGirl.define do
	factory :feeder_task do
		sequence(:name) {|n| "Sub Task #{n}"}
	end
end