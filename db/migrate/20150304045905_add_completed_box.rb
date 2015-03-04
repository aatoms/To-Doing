class AddCompletedBox < ActiveRecord::Migration
  def change
    add_column :tasks, :complete, :boolean
  end
end
