class RegardsController < ApplicationController
  def index
    @regards = Regard.users_regards(current_user)
  end
end
