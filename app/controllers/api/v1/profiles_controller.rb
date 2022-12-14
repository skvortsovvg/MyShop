class Api::V1::ProfilesController < Api::V1::BaseController
  def me
    render json: current_user_owner
  end
end