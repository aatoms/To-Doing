class TasksController < PrivateController
  before_action :set_project
  before_action :auth
  before_action :set_task, only: [:edit, :show, :update, :destroy]
  before_action :ensure_member

  def index
    @tasks = @project.tasks
    @name = @project.name
  end

  def new
    @task = Task.new
  end

  def show
    @task = Task.find(params[:id])
    @comments = @task.comments
    @comment = @task.comments.new
  end

  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      flash[:notice] = "Task was successfully created"
      redirect_to project_tasks_path(@project.id)
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = @project.tasks.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = "Task was successfully updated"
      redirect_to project_tasks_path(@project.id)
    else
      render :edit
    end
  end

  def destroy
    @task = @project.tasks.find(params[:id])
    @task.destroy
    redirect_to project_tasks_path(@project.id), notice: "Task was successfully deleted"
  end

  private

  def set_task
    @task = @project.tasks.find(params[:id])
  end


  def set_project
    @project = Project.find(params[:project_id])
  end

  def task_params
    params.require(:task).permit(:description, :complete, :due_date)
  end

end
