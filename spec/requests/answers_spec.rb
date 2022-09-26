require 'rails_helper'

RSpec.describe "Answers", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/questions/1/answers/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/questions/1/answers/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/questions/1/answers/1/"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "returns http success" do
      get "/questions/1/answers"
      expect(response).to have_http_status(:success)
    end
  end
end
