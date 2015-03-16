require 'rails_helper'

  feature 'Users' do
    before :each do
      User.create(first_name: 'Testing', last_name: 'Test', email: 'test@example.com')
    end

    scenario 'creates a new user' do
      visit new_user_path
      fill_in :user_first_name, with: 'Christian'
      fill_in :user_last_name, with: 'Bale'
      fill_in :user_email, with: 'batman@example.com'
      click_on 'Create User'
      expect(page).to have_content('User was created successfully')
      expect(page).to have_content('First Name Christian')
      expect(page).to have_content('Last Name Bale')
      expect(page).to have_content('Email batman@example.com')
    end

    scenario 'User can see a user when clicking on user' do
      visit users_path
      click_on 'Testing Test'
      expect(page).to have_content('Testing')
      expect(page).to have_content('Test')
      expect(page).to have_content('test@example.com')
    end

    scenario 'User can edit user' do
      visit users_path
      click_on 'Edit'
      fill_in :user_first_name, with: 'Austin'
      fill_in :user_last_name, with: 'Atoms'
      fill_in :user_email, with: 'austin@test.com'
      click_on 'Update User'
      expect(page).to have_content('User was updated successfully')
    end

    scenario 'User can delete user' do
      visit users_path
      click_on "Delete"
      expect(page).to have_content('The user has been successfully deleted')
      expect(page).to have_no_content('Austin Adams')
    end

    scenario 'User cannot add user without first and last name and email' do
      visit new_user_path
      click_on 'Create User'
      expect(page).to have_content("First name can't be blank")
      expect(page).to have_content("Last name can't be blank")
      expect(page).to have_content("Email can't be blank")
    end

  end
