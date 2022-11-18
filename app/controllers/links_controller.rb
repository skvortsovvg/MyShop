class LinksController < ApplicationController
  def destroy
    @link_id = params[:link_id]
    Link.find_by(id: @link_id).destroy
  end
end
