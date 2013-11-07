namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		User.create!(	name: "First User",
						email: "First@webfilings.com",
						password: "sample",
						password_confirmation: "sample",
						admin: false)
		User.create!(	name: "Example User",
						email: "example@webfilings.com",
						password: "sample",
						password_confirmation: "sample",
						admin: true)
		User.create!(	name: "Mike Breecher",
						email: "Mike.Breecher@webfilings.com",
						password: "sample",
						password_confirmation: "sample",
						admin: true)
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