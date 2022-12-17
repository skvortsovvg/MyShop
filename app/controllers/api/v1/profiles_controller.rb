class Api::V1::ProfilesController < Api::V1::BaseController
  def me
    render json: current_user_owner
  end
  def users
    render json: User.where.not(id: current_user_owner.id)
  end
end