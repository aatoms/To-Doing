class MembershipsController < ApplicationController
  before_action :find_set_project

  def index
    @memberships = @project.memberships
    @membership = @project.memberships.new
    @name = @project.name
  end

  def new
    @membership = @project.membership.new
  end

  def create
    @membership = @project.memberships.new(membership_params)
    if @membership.save
      flash[:notice] = "#{@membership.user.full_name} was successfully added"
      redirect_to project_memberships_path(@project.id)
    else
      render :index
    end
  end

  def update
    @membership = @project.memberships.find(params[:id])
    if @membership.update(membership_params)
      flash[:notice] = "#{@membership.user.full_name} was successfully updated"
      redirect_to project_memberships_path(@project.id)
    else
      render :index
    end
  end

  def destroy
    @membership = @project.memberships.find(params[:id])
    @membership.destroy
    flash[:notice] = "#{@membership.user.full_name} was successfully removed"
    redirect_to project_memberships_path(@project.id)
  end

  private

  def find_set_project
    @project = Project.find(params[:project_id])
  end

  def membership_params
    params.require(:membership).permit(:user_id, :project_id, :role)
  end

end
