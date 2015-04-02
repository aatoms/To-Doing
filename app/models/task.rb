class Task < ActiveRecord::Base
  validates :description, :due_date, presence: true
  belongs_to :project
  has_many :comments, :dependent => :destroy
end
