class PrivateController < ApplicationController
  helper_method :owner_count
  helper_method :current_user
  before_action :auth

  def auth
   unless current_user
     session[:save_session] ||= request.fullpath
     flash[:danger] = "You must sign in"
     redirect_to sign_in_path
   end
 end

  def owner_count(project)
    @project.memberships.where(role:2).count
  end

  def ensure_owner_self
    if current_user.admin == false && (!(current_user.memberships.find_by(project_id: @project).role == "Owner" || current_user.id == @membership.user_id))
      flash[:danger] = "You don't have access"
      redirect_to project_path(@project)
    end
  end

  def ensure_owner
    if current_user.admin == false && (current_user.memberships.find_by(project_id: @project).role != "Owner")
      flash[:danger] = "You don't have access!"
      redirect_to projects_path(@project)
    end
  end

  def ensure_member
    if current_user.admin == false && !current_user.projects.include?(@project)
      flash[:danger] = "You do not have access to that project"
      redirect_to projects_path
    end
  end

  def ensure_owner_present
    if (@project.memberships.where(role: "Owner").count <= 1 && @membership.role == "Owner")
      flash[:danger] = "Projects must have at least one owner"
      redirect_to project_memberships_path(@project)
    end
  end

  def set_membership
    @project = Project.find(params[:project_id])
    @membership = @project.memberships.find(params[:id])
  end

  def current_user_not_permitted
    unless @user == current_user || current_user.admin
      render file: 'public/404.html', status: 404, layout: false
    end
  end

end
