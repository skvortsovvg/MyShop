class LinksController < ApplicationController
  def destroy
    byebug
    @link_id = params[:link_id]
    Link.find_by(id: @link_id).destroy
  end
end
