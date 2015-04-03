def create_project
  Project.create!(
    name: "Project"
  )
end

def create_task(project, overrides = {})
  defaults = {
    description: "TEST TASK",
    project_id: project.id
    }
  Task.create!(defaults.merge(overrides))
end

def create_membership(overrides = {})
  @project = create_project
  @user = create_user_1({admin: false})
  defaults = {project_id: @project.id,
     user_id: @user.id,
     role: "Member"
     }
  Membership.create!(defaults.merge(overrides))
end

def create_user_1(options= {})
  defaults = {first_name: 'Austin',
    last_name: 'Adams',
    email: 'austin@example.com',
    password: 'password',
    password_confirmation: 'password',
    admin: true
    }
  User.create!(defaults.merge(options))
end

def create_user_2(options= {})
  defaults = {first_name: 'Dexter',
    last_name: 'Morgan',
    email: 'dexter@example.com',
    password: 'password',
    password_confirmation: 'password',
    admin: true
    }
  User.create!(defaults.merge(options))
end
