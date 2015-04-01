class PublicController < ApplicationController
  skip_before_action :auth

end
