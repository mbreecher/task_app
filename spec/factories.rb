FactoryGirl.define do
	factory :user do
		name	"Mike Breecher"
		email	"mike.breecher@webfilings.com"
		password	"foobar"
		password_confirmation	"foobar"
	end
end