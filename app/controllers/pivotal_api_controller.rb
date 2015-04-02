class PivotalApiController < PrivateController

  def show
    tracker = PivotalApi.new.stories(current_user.tracker_token, params[:id])
    @project_name = params[:project_name]
  end
end
