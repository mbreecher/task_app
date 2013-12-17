class Customer < ActiveRecord::Base
	#has_one :users
	belongs_to :user, class_name: User, foreign_key: :csm_id
	has_many :tasks, foreign_key: "customer_id"
	validates :name, presence: true, length: {maximum: 50}
	validates :start, presence: true
end
