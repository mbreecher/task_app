class Task < ActiveRecord::Base
	validates :name, presence: true, length: {maximum: 50}
	validates :reference, presence: true
	validates :offset, presence: true
end
