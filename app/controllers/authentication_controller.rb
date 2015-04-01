class AuthenticationController < ApplicationController
  skip_before_action :auth

  def new

  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You have successfully logged in"
      redirect_to projects_path
    else
      flash[:danger] = "Email / Password combination is invalid"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have successfully logged out"
    redirect_to root_path
  end

end
