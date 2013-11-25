class Customer < ActiveRecord::Base
	belongs_to :user
	has_many :tasks, foreign_key: "customer_id"
	validates :name, presence: true, length: {maximum: 50}
	validates :start, presence: true
end
