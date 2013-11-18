class Customer < ActiveRecord::Base
	belongs_to :user
	validates :name, presence: true, length: {maximum: 50}
	validates :start, presence: true
end
