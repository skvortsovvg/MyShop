class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :set_user

  private

  def set_user
    gon.user_id = current_user&.id || 'guest'
  end
end
