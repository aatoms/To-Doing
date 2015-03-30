require 'rails_helper'

feature 'user can comment on tasks' do
  before do
    @project1 = Project.create!(name: "Project")
    @task1 = Task.create!(description: 'Task', due_date: '2015-04-10', project_id: @project1.id)
    @comment1 = Comment.create!(content: "THIS COMMENT IS SWEET")
  end

  scenario 'comment can be added' do
    user = create_user(email: "bar@example.com")
    sign_in(user)
    visit project_task_path(@project1, @task1)
    fill_in "comment_content", with: "commenting on a task!"
    click_on "Add Comment"
    expect(page).to have_content "commenting on a task!"
    expect(page).to have_content "less than a minute ago"
    expect(page).to have_content "first last"
  end

end
