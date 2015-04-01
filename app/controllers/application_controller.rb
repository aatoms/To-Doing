class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :all
  helper_method :auth
  helper_method :current_user


  def current_user
    if session[:user_id].present?
      @user = User.find(session[:user_id])
    end
  end

  def auth
   unless current_user
     flash[:danger] = "You must sign in"
     redirect_to sign_in_path
   end
 end

  def ensure_member
    if !current_user.projects.include?(Project.find(params[:id]))
      flash[:notice] = "You don't have access to that project!"
      redirect_to projects_path
    end
  end

end
