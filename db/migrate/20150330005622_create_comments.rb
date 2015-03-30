class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :task_id
      t.integer :user_id
      t.integer :project_id
      t.datetime :created_at
    end
  end
end
