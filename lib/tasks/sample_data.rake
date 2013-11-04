namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		User.create!(	name: "Example User",
						email: "example@webfilings.com",
						password: "sample",
						password_confirmation: "sample")
		99.times do |n|
			name = Faker::Name.name
			email = "example-#{n+1}@webfilings.com"
			password = "sample"
			User.create!(	name: name,
							email: email,
							password: password,
							password_confirmation: password)
		end
	end
end