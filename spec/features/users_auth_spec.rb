require 'rails_helper'

  feature 'Users' do
    before do
      @user = create_user_1
    end

    scenario 'can sign up' do
      visit root_path
      click_on 'Sign Up'
      expect(page).to have_content("Sign up for gCamp!")
      fill_in :user_first_name, with: 'First'
      fill_in :user_last_name, with: 'Last'
      fill_in :user_email, with: 'example@mail.com'
      fill_in :user_password, with: 'password'
      fill_in :user_password_confirmation, with: 'password'
      within('form') {click_on 'Sign Up'}
      expect(current_path).to eq new_project_path
      expect(page).to have_content("You have successfully signed up")
      expect(page).to have_content("First Last")
      expect(page).to have_no_content("Sign Up")
    end

    scenario 'that are logged in can see projects, tasks, and users' do
      visit projects_path
      sign_in_1(@user)
      click_on 'Projects'
      expect(page).to have_content('Projects')
      click_on 'Users'
      expect(page).to have_content('Users')
    end

    scenario 'can signout' do
      visit root_path
      sign_in_1(@user)
      click_on 'Sign Out'
      expect(page).to have_content('You have successfully logged out')
      expect(page).to have_no_content('Sign Out')
      expect(current_path).to eq '/'
    end

    scenario 'can sign in with valid credentials' do
      sign_in_1(@user)
      expect(page).to have_content("You have successfully logged in")
      expect(current_path).to eq projects_path
    end

end
