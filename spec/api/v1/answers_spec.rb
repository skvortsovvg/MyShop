require 'rails_helper'

describe "Answers API", type: :request do
  let(:headers) do
    { "CONTENT_TYPE" => "application/json",
      "ACCEPT" => "application/json" }
  end

  describe "GET /api/v1/...answers" do
    context 'unauthorized' do
      it "returns 401 if has not access_token" do
        get('/api/v1/questions/1/answers', headers:)
        expect(response.status).to eq 401
      end

      it "returns 401 if access_token is invalid" do
        get('/api/v1/questions/1/answers', params: { access_token: "123" }, headers:)
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:access_token) { FactoryBot.create(:access_token) }
      let(:question) { FactoryBot.create(:question) }
      let!(:answers) { FactoryBot.create_list(:answer, 2, question:) }
      let(:answer) { answers.first }
      let(:answer_response) { json.first }

      before { get "/api/v1/questions/#{question.id}/answers", params: { access_token: access_token.token }, headers: }

      it "returns 200 ok" do
        expect(response.status).to eq 200
      end

      it "returns list of answers" do
        expect(json.size).to eq 2
      end

      it "returns all public fields" do
        %w[id body author_id created_at updated_at].each do |attr|
          expect(answer_response[attr]).to eq answer.send(attr).as_json
        end
      end
    end
  end
end
