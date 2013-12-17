class Task < ActiveRecord::Base
	#belongs_to :user
	belongs_to :customer, class_name: Customer, foreign_key: :customer_id
	belongs_to :user, class_name: User, foreign_key: :csm_id
	validates :name, presence: true, length: {maximum: 50}
	validates :due_date, presence: true

	def self.search(search)
		if search
			where 'name LIKE ?', "%#{search}%"
		else
			scoped
		end
	end
end
