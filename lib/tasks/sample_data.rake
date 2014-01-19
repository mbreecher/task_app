namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		User.create!(	name: "First User",
						email: "First@webfilings.com",
						password: "Sample-100",
						password_confirmation: "Sample-100",
						admin: false)
		User.create!(	name: "Example User",
						email: "example@webfilings.com",
						password: "Sample-100",
						password_confirmation: "Sample-100",
						admin: true)
		User.create!(	name: "Mike Breecher",
						email: "Mike.Breecher@webfilings.com",
						password: "Sample-100",
						password_confirmation: "Sample-100",
						admin: true)
		Customer.create!(	name: "Test Company",
							start: "1/1/2013",
							fiscal_ye: "12/31/2013",
							next_per_end: "12/31/2013",
							next_target: "2/28/2014",
							csm_id: "3")
		99.times do |n|
			name = Faker::Name.name
			email = "example-#{n+1}@webfilings.com"
			password = "Sample-100"
			User.create!(	name: name,
							email: email,
							password: password,
							password_confirmation: password)
			Customer.create!(name: "Company #{n+1}",
							start: "1/1/2013",
							fiscal_ye: "12/31/2013",
							next_per_end: "12/31/2013",
							next_target: "2/28/2014",
							csm_id: "#{rand(10)+1}")
		
		end

		50.times do |n|
			Task.create!(	name: "Task #{n+1}",
							instructions: "how to...",
							due_date: Date.new(2014 + rand(1), rand(11)+1, rand(30)+1),
							customer_id: "#{rand(10)+1}", 
							csm_id: "#{rand(5)+1}")
		end
		10.times do |n|
			TaskSet.create!(	name: "Task Set #{n+1}",
								csm_id: "#{rand(5)+1}")
		end
		50.times do |n|
			FeederTask.create!(	name:"Sub Task #{n+1}",
								instructions: "do something",
								reference: "filing date",
								offset: "#{rand(30)+1}",
								task_set_id: "#{rand(9)+1}")
		end
	end
end