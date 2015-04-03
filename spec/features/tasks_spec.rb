require 'rails_helper'

feature 'Tasks' do
  before do
    sign_in_1
    @project1 = Project.create!(name: "Project")
    @task1 = Task.create!(description: 'Task', due_date: '2015-04-10', project_id: @project1.id)
  end

  scenario 'User creates a new task' do
    visit project_tasks_path(@project1, @task1)
    click_on "New Task"
    fill_in :task_description, with: 'New Task'
    fill_in :task_due_date, with: '2015-04-10'
    click_on 'Create Task'
    expect(page).to have_content('Task was successfully created')
    expect(page).to have_content('New Task')
    expect(page).to have_content('04/10/2015')
  end

  scenario 'User can see a task when clicking on name' do
    visit project_tasks_path(@project1, @task1)
    click_on @task1.description
    expect(page).to have_content('Task')
    expect(page).to have_content('Due Date: 04/10/2015')
  end

  scenario 'User can edit task' do
    visit project_task_path(@project1, @task1)
    click_on 'Edit'
    fill_in :task_description, with: 'Test Task 2'
    click_on 'Update Task'
    expect(page).to have_content('Task was successfully updated')
    expect(page).to have_content('Test Task 2')
  end

  scenario 'User can delete task' do
    visit project_tasks_path(@project1)
    page.find(".glyphicon-remove").click
    expect(page).to have_no_content('Test Task 2')
  end

  scenario 'User cannot add task without description' do
    visit new_project_task_path(@project1)
    fill_in :task_due_date, with: '2015-04-10'
    click_on 'Create Task'
    expect(page).to have_content("Description can't be blank")
  end

end
