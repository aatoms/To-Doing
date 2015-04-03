  def sign_in_1(user = create_user_1)
    visit root_path
    click_on 'Sign In'
    fill_in :email, with: 'austin@example.com'
    fill_in :password, with: 'password'
    click_button 'Sign In'
  end


  def sign_in_2(user = create_user_2)
    visit root_path
    click_link 'Sign In'
    fill_in :email, with: 'dexter@example.com'
    fill_in :password, with: 'password'
    click_on 'Sign In'
  end
