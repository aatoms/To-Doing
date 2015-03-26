class MembershipsController < ApplicationController
  before_action :find_set_project

  def index
    @memberships = @project.memberships
    @membership = @project.memberships.new
    @name = @project.name
  end

  def new
    @membership = @project.memberships.new
  end

  def create
    @membership = @project.memberships.new(membership_params)
    if @membership.save
      flash[:notice] = "User has been successfully added"
      redirect_to project_memberships_path(@project.id)
    else
      render :new
    end
  end

  def edit
    @membership = @project.memberships.find(params[:id])
  end

  def show
    @membership = @project.memberships.find(params[:id])
  end

  def update
    @membership = @project.memberships.find(params[:id])
    if @membership.update(membership_params)
      flash[:notice] = "User has been successfully updated"
      redirect_to project_memberships_path(@project.id)
    else
      render :edit
    end
  end

  def destroy
    @membership = @project.memberships.find(params[:id])
    membership = Membership.find(params[:id])
    membership.destroy
    flash[:notice] = "Membership Destroyed"
  end

  private

  def find_set_project
    @project = Project.find(params[:project_id])
  end

  def membership_params
    params.require(:membership).permit(:user_id, :project_id, :role)
  end

end
