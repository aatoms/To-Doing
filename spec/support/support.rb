def sign_in
  user = User.new(first_name: 'First', last_name: 'Last', email: 'email@example.com', password: 'password', password_confirmation: 'password')
  user.save!
  visit root_path
  click_on 'Sign In'
  fill_in :email, with: 'email@example.com'
  fill_in :password, with: 'password'
  click_button 'Sign In'
