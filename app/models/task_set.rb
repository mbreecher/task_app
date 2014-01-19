class TaskSet < ActiveRecord::Base
	belongs_to :user, class_name: User, foreign_key: :csm_id
	has_many :feeder_tasks, foreign_key: :task_set_id, dependent: :destroy
end
