class PrivateController < ApplicationController
  helper_method :owner_count
  before_action :auth

  def auth
   unless current_user
     flash[:danger] = "You must sign in"
     redirect_to sign_in_path
   end
 end

  def owner_count(project)
    @project.memberships.where(role:2).count
  end

  def ensure_owner_self
    unless (current_user.memberships.find_by(project_id: @project).role == "Owner" || current_user.id == @membership.user_id)
      flash[:danger] = "You don't have access"
      redirect_to project_path(@project)
    end
  end

  def ensure_owner
    if (current_user.memberships.find_by(project_id: @project).role != "Owner")
      flash[:danger] = "You don't have access!"
      redirect_to projects_path(@project)
    end
  end

  def ensure_owner_present
    if @project.memberships.where(role: "Owner").count <= 1 && @membership.role == "Owner"
      flash[:danger] = "Projects must have at least one owner"
      redirect_to project_memberships_path(@project)
    end
  end

  def set_membership
    @project = Project.find(params[:project_id])
    @membership = @project.memberships.find(params[:id])
  end


end
