require 'rails_helper'

feature 'Tasks' do
  before do
    Task.create(description: 'Test Task', due_date: '2015-04-10')
  end

  scenario 'User creates a new task' do
    visit new_task_path
    fill_in :task_description, with: 'New Task'
    fill_in :task_due_date, with: '2015-04-10'
    click_on 'Create Task'
    expect(page).to have_content('Task was successfully created')
    expect(page).to have_content('New Task')
    expect(page).to have_content('Due On: 04/10/2015')
  end

  scenario 'User can see a task when clicking on name' do
    visit tasks_path
    click_on 'Test Task'
    expect(page).to have_content('Test Task')
    expect(page).to have_content('Due On: 04/10/2015')
  end

  scenario 'User can edit task' do
    visit tasks_path
    click_on 'Edit'
    fill_in :task_description, with: 'Test Task 2'
    click_on 'Update Task'
    expect(page).to have_content('Task was successfully updated')
    expect(page).to have_content('Test Task 2')
  end

  scenario 'User can delete task' do
    visit tasks_path
    click_on "Delete"
    expect(page).to have_no_content('Test Task 2')
  end

  scenario 'User cannot add task without description' do
    visit new_task_path
    fill_in :task_due_date, with: '2015-04-10'
    click_on 'Create Task'
    expect(page).to have_content("Description can't be blank")
  end

end
