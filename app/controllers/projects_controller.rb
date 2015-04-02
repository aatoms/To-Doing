class ProjectsController < PrivateController
  before_action :auth
  before_action :set_project, only: [:edit, :show, :update, :destroy]
  before_action :ensure_member, only: []
  before_action :ensure_owner, only: [:edit, :update, :destroy]

  def index
    @projects = Project.all
    if current_user.tracker_token?
      pivotal_api = PivotalApi.new
      @pivotal_projects = pivotal_api.projects(current_user.tracker_token)
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      @project.memberships.create!(project_id: @project.id, user_id: current_user.id, role: "Owner")
      flash[:notice] = "Project was successfully created"
      redirect_to project_tasks_path(@project, @task)
    else
      render :new
    end
  end

  def edit
  end

  def show
  end

  def update
    if @project.update(project_params)
      flash[:notice] = "Project was successfully updated"
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def destroy
    project = Project.find(params[:id])
    project.destroy
    redirect_to projects_path, notice: "Project was successfully deleted"
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end

end
