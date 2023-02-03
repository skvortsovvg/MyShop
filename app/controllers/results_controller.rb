class ResultsController < ApplicationController
  def index
    # @search_results = Question.search_everywhere(params[:query])
    @search_results = PgSearch.multisearch(params[:query])
  end
end
