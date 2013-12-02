class Task < ActiveRecord::Base
	#belongs_to :user
	belongs_to :customer
	validates :name, presence: true, length: {maximum: 50}
	validates :customer_id, presence: true
	validates :due_date, presence: true
end
