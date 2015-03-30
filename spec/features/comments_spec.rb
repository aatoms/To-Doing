require 'rails_helper'

feature 'user can comment on tasks' do
  before do
    sign_in
    @project1 = Project.create!(name: "Project")
    @task1 = Task.create!(description: 'Task', due_date: '2015-04-10', project_id: @project1.id)
  end

  scenario 'comment can be added' do
    visit project_task_path(@task.project, @task1)
    fill_in "comment_content", with: "commenting on a task!"
    click_on "Add Comment"
    expect(page).to have_content "commenting on a task!"
    expect(page).to have_content "less than a minute ago"
    expect(page).to have_content "First Last"
  end

  scenario 'if user is deleted, comment author changes to deleted' do
      task = create_task
      user = create_user
      comment = Comment.create!(user_id: user.id, task_id: task.id, body: "THIS COMMENT IS SWEET")
      sign_in_user
      visit project_task_path(task.project, task)
      expect(page).to have_content "First Last"
      expect(page).to have_content "THIS COMMENT IS SWEET"
      visit users_path
      click_on user.first_name
      click_on "Edit"
      click_on "Delete"
      visit project_task_path(task.project, task)
      expect(page).to have_content "THIS COMMENT IS SWEET"
      expect(page).to_not have_content "First Last"
      expect(page).to have_content "deleted"
    end
end
