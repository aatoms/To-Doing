class Task < ActiveRecord::Base
  validates :description, :due_date, presence: true
  belongs_to :project
end
