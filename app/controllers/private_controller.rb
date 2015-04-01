class PrivateController < ApplicationController
  helper_method :owner_count
  before_action :auth

  def auth
   unless current_user
     flash[:danger] = "You must sign in"
     redirect_to sign_in_path
   end
 end

  def ensure_owner
    if current_user.memberships.find_by(project_id: @project).role != "owner"
      flash[:warning] = "You don't have access!"
      redirect_to projects_path
    end
  end

  def owner_count(project)
    @project.memberships.where(role:2).count
  end

end
