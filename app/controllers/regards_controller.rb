class RegardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @regards = Regard.users_regards(current_user)
  end
end
