class TasksController < ApplicationController
  # before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :find_set_project
  before_action :auth

  def index
    @tasks = @project.tasks
    @name = @project.name
  end

  def new
    @task = @project.tasks.new
  end

  def show
    @task = Task.find(params[:id])
  end

  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      flash[:notice] = "Task was successfully created"
      redirect_to project_task_path(@project, @task)
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = "Task was successfully updated"
      redirect_to project_task_path(@project, task)
    else
      render :edit
    end
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to project_tasks_path(@project), notice: "Task was successfully deleted"
  end

  private

  def find_set_project
    @project = Project.find(params[:project_id])
  end

  def task_params
    params.require(:task).permit(:description, :complete, :due_date, :project_id)
  end

  # def set_task
  #   @tasks = Project.tasks.find(params[:project_id])
  # end

end
