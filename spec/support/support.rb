  def create_user(options= {})
    defaults = {first_name: 'first', last_name: 'last', email: 'email@example.com', password: 'password', password_confirmation: 'password'}
    User.create!(defaults.merge(options))
  end

  def sign_in(user = create_user)
    visit root_path
    click_on 'Sign In'
    fill_in :email, with: user.email
    fill_in :password, with: 'password'
    click_button 'Sign In'
  end

  def create_project
    @project1 = Project.create(name: "Test Project")
  end

  def create_task
    project = create_project
    Task.create!(description: "TestTask", project_id: project.id)
  end
