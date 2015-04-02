class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :all
  helper_method :auth
  helper_method :current_user

  def current_user
    if session[:user_id].present?
      @current_user = User.find(session[:user_id])
    end
  end

end
