require 'rails_helper'

describe ProjectsController do
  before(:each) do
    user_2 = create_user_2
    session[:user_id] = user_2.id
  end

  describe "GET #index" do
    it "assigns @projects" do
      project = create_project
      get :index
      expect(assigns(:projects)).to eq [project]
    end

    it "will not allow unathenticated users access" do
      session[:user_id] = nil
      get :index
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "GET #new" do
    it "assigns a new project object" do
      get :new
      expect(assigns(:project)).to be_a_new(Project)
    end

    it "renders the new template" do
      get :new
      expect(subject).to render_template(:new)
    end
  end

  describe "GET #show" do
    it "will not allow non-members to view @project" do
      project = create_project
      user = create_user_1({admin: false})
      session[:user_id] = user.id
      get :show, id: project
      expect(response).to render_template(:show)
    end

    it "allows members to view @project" do
      project = create_project
      membership = create_membership({project_id: project.id, role: "Member"})
      get :show, id: project
      expect(response).to render_template(:show)
    end
  end


  describe "GET #edit" do
    it "will not allow non-owners to edit project" do
      project = create_project
      membership = create_membership({project_id: project.id, role: "Member"})
      session[:user_id] = @user.id
      get :show, id: project
      expect(response).to_not render_template(:edit)
    end
  end

  describe "POST #update" do
    it "will not allow members to update" do
      project = create_project
      membership = create_membership({project_id: project.id, role: "Member"})
      session[:user_id] = @user.id
      expect {
        patch :update, id: project,
        project: {name: "edited test project"}
      }.to_not change{Project.last}
      expect(flash[:danger]).to eq "You don't have access!"
      expect(response).to redirect_to project_path(project)
    end
  end

    it "will allow an owner to update project" do
      project = create_project
      membership = create_membership({project_id: project.id, role: "Owner"})
      session[:user_id] = @user.id
      expect {
        patch :update, id: project.id, project: {name: "Test Project"}
      }.to change{project.reload.name}.from('Project').to('Test Project')

      expect(response).to redirect_to project_path(project)
      expect(flash[:notice]).to eq "Project was successfully updated"
    end

  describe "DELETE #destroy" do
    it "will not allow non-owner, non-admin to delete a project" do
      project = create_project
      membership = create_membership({project_id: project.id, role: "Member"})
      session[:user_id] = @user.id
      expect {
        delete :destroy, id: project
      }.to_not change{Project.all.count}
      expect(flash[:danger]).to eq "You don't have access!"
    end

    it "will allow an owner to delete a project" do
      project = create_project
      membership = create_membership({project_id: project.id, role: "Owner"})
      session[:user_id] = @user.id
      expect {
        delete :destroy, id: project
      }.to change{Project.all.count}.by(-1)
      expect(flash[:notice]).to eq "Project was successfully deleted"
    end
  end

end
