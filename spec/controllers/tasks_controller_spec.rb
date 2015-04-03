require 'rails_helper'

describe TasksController do
  before do
    User.destroy_all
  end

  describe 'GET #index' do
    it "assigns @project.tasks" do
      user = create_user_1({email: "austin@example1.com", admin: false})
      session[:user_id] = user.id
      project = create_project
      Membership.create!(user_id: user.id, project_id: project.id)
      task = create_task(project)

      get :index, project_id: project.id

      expect(assigns(:tasks)).to eq [task]
    end

    it "will allow members to view tasks" do
      user = create_user_1({email: "austin@example.com", admin: false})
      session[:user_id] = user.id
      project = create_project
      Membership.create!(user_id: user.id, project_id: project.id)

      get :index, project_id: project.id

      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it "will not allow non admin, non members to view new task template" do
      project = create_project
      user = create_user_1({admin: false})
      session[:user_id] = user.id

      get :new, project_id: project.id

      expect(response).to redirect_to projects_path
      expect(flash[:danger]).to eq "You do not have access to that project"
    end

    it "will allow admins to view new task template" do
      project = create_project
      user = create_user_1
      session[:user_id] = user.id

      get :new, project_id: project.id

      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    it "asssigns @project.tasks to updated task" do
      user = create_user_1
      session[:user_id] = user.id
      project = create_project
      post :new, project_id: project.id
      expect(assigns(:task)).to be_a_new(Task)
    end

    it "creates a new task when valid params are passed" do
      user = create_user_1
      session[:user_id] = user.id
      project = create_project
      expect{post :create, project_id: project.id, task:{description: "pointer"}}.to change{project.tasks.all.count}.from(0).to(1)
    end

    it "allows members to create a new task" do
      user = create_user_1({admin: false})
      session[:user_id] = user.id
      project = create_project
      membership = Membership.create!(project_id: project.id, user_id: user.id, role: "Member")
      expect{post :create, project_id: project.id, task:{description: "pointer"}}.to change{project.tasks.all.count}.from(0).to(1)
      expect(response).to redirect_to project_tasks_path(project)
      expect(flash[:notice]).to eq "Task was successfully created"
    end
  end

  describe "GET #show" do
    it "assigns tasks" do
      user = create_user_1({admin: false})
      session[:user_id] = user.id
      project = create_project
      task = create_task(project)

      get :show, project_id: project.id, id: task.id

      expect(assigns(:task)).to eq task
    end

    it "does not allow non members non admins to see task" do
      user = create_user_1({admin: false})
      session[:user_id] = user.id
      project = create_project
      task = create_task(project)

      get :show, project_id: project.id, id: task.id

      expect(response).to_not render_template(:show)
      expect(response).to redirect_to projects_path
      expect(flash[:danger]).to eq "You do not have access to that project"
    end
  end

  describe "GET #edit" do
    it "assigns tasks" do
      user = create_user_1({admin: false})
      session[:user_id] = user.id
      project = create_project
      task = create_task(project)

      get :edit, project_id: project.id, id: task.id

      expect(assigns(:task)).to eq task
    end
  end

  describe "PATCH #update" do
    it "does not allow non members or non admins to update task" do
      user = create_user_1({admin: false})
      session[:user_id] = user.id
      project = create_project
      task = create_task(project)

      expect{
        patch :update, project_id: project.id, id: task.id, task:{description: "pointer"}
      }.to_not change{project.tasks}

      expect(response).to redirect_to projects_path
      expect(flash[:danger]).to eq "You do not have access to that project"
    end

    it "allows admins to update task" do
      user = create_user_1
      session[:user_id] = user.id
      project = create_project
      task = create_task(project)

      expect{
        patch :update, project_id: project.id, id: task.id, task:{description: "pointer"}
      }.to change{ project.tasks.last.description }.from("TEST TASK").to("pointer")

      expect(response).to redirect_to project_tasks_path(project.id)
      expect(flash[:notice]).to eq "Task was successfully updated"
    end
  end

  describe "DELETE #destroy" do

    it "allows members to delete task" do
      user = create_user_1
      session[:user_id] = user.id
      project = create_project
      task = create_task(project)
      membership = Membership.create!(project_id: project.id, user_id: user.id, role: "Member")

      expect {
        delete :destroy, project_id: project.id, id: task.id
      }.to change{project.tasks.all.count}.by(-1)
      
      expect(response).to redirect_to project_tasks_path(project.id)
    end
  end


end
