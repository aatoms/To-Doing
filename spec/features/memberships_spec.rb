require 'rails_helper'

feature 'manage memberships' do
  before do
    @project = Project.create!(name: "project")
    @user = create_user
    Membership.create!(project_id: @project.id, user_id: @user.id, role: "Member")
  end

  scenario 'memberships page shows all memberships' do
    user = create_user(email: "bar@example.com")
    sign_in(user)
    visit projects_path
    click_on 'project'
    click_on '1 Member'
    expect(page).to have_content "first last"
  end

  # scenario 'user can choose member from collection, select role, and create new member' do
  #   user = create_user(first_name: "george", email: "foo@email.com")
  #   sign_in(user)
  #   visit project_memberships_path(@project, @user)
  #   click_on "Add New Member"
  #     select user.full_name, from: 'membership_user_id'
  #   within(".first-table") do
  #     select "Owner", from: 'membership_role'
  #   end
  #   click_on "Add New Member"
  #   expect(page).to have_content "first last was successfully added"
  #   select user.full_name, from: 'membership_user_id'
  #   click_on "Add New Member"
  #   expect(page).to have_content "User has already been added to this project"
  # end
  #
  # scenario 'user can delete member from index page' do
  #   user = create_user(email: "foo@email.com")
  #   sign_in(user)
  #   visit project_memberships_path(@project, @user)
  #   select user.full_name, from: 'membership_user_id'
  #   select "Owner", from: 'membership_role'
  #   click_on "Add New Member"
  #   expect(page).to have_content "first last"
  #   find(".glyphicon").click
  #   expect(page).to have_content "first last was successfully removed"
  # end

end
