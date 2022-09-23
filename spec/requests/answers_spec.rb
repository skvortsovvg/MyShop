require 'rails_helper'

RSpec.describe "Answers", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/answers/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/answers/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/answers/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/answers/create"
      expect(response).to have_http_status(:success)
    end
  end

end
