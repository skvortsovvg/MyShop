require 'rails_helper'

RSpec.describe "Regards", type: :request do
  describe "GET /regards" do
    it "returns http success" do
      get "/regards/regards"
      expect(response).to have_http_status(:success)
    end
  end

end
