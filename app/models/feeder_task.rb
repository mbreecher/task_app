class FeederTask < ActiveRecord::Base
	belongs_to :task_set, class_name: TaskSet, foreign_key: :task_set_id
end
