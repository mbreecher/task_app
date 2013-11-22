FactoryGirl.define do
	factory :user do
		sequence(:name) {|n| "Person #{n}"}
		sequence(:email) { |n| "person_test_#{n}@webfilings.com"}
		password	"foobar"
		password_confirmation	"foobar"

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
		
		factory :account do
			csm_id "1"
		end
	end
end