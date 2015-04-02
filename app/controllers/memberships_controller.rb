class MembershipsController < PrivateController
  before_action :set_project
  before_action :set_membership, only: [:destroy, :update]
  before_action :ensure_member
  before_action :ensure_owner, only: [:update]
  before_action :ensure_owner_self, only: [:destroy]
  before_action :ensure_owner_present, only: [:update, :destroy]

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
    membership = Membership.find(params[:id])
    membership.destroy
    flash[:notice] = "#{membership.user.full_name} was successfully removed"
    if current_user.id == @membership.user_id
      redirect_to projects_path
    else
      redirect_to project_memberships_path(@project.id)
    end
  end

  private


  def set_project
    @project = Project.find(params[:project_id])
  end


  def membership_params
    params.require(:membership).permit(:user_id, :project_id, :role)
  end

end
