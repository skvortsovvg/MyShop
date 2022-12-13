class Api::V1::ProfilesController < ApplicationController
  # before_action :doorkeeper_authorize!

  def me
    render json: current_user_owner
  end

  private

  def current_user_owner
    @current_user_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end