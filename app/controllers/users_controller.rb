class UsersController < PrivateController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :auth
  before_action :current_user_not_permitted, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User was created successfully"
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User was updated successfully"
      redirect_to user_path
    else
      render :edit
    end
  end

  def destroy
    if current_user == @user
      @user.destroy
      flash[:notice] = "User was successfully deleted"
      redirect_to root_path
      session.clear
    else
      @user.destroy
      flash[:notice] = "User was successfully deleted"
      redirect_to users_path
    end
  end

  private

  def user_params
    if current_user.admin
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :tracker_token, :admin)
    else
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :tracker_token)
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

end
