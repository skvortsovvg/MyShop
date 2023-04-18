class Api::V1::BaseController < ApplicationController
  # before_action :doorkeeper_authorize!

  private

  def current_user_owner
    @current_user_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
