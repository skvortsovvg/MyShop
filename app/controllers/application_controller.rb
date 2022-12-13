class ApplicationController < ActionController::Base
  before_action :set_user

  rescue_from CanCan::AccessDenied do |exeption|
    redirect_to root_path, alert: exeption.message
  end

  private

  def set_user
    gon.user_id = current_user&.id || 'guest'
  end
end
