require 'rails_helper'

describe "Questions API", type: :request do
  let(:headers) { { "CONTENT_TYPE" => "application/json",
                    "ACCEPT" => "application/json"} }

  describe "GET /api/v1/questions" do
    context 'unauthorized' do
      it "returns 401 if has not access_token" do
        get '/api/v1/questions', headers: headers
        expect(response.status).to eq 401
      end

      it "returns 401 if access_token is invalid" do
        get '/api/v1/questions', params: { access_token: "123" }, headers: headers
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:access_token) { FactoryBot.create(:access_token) }
      let!(:questions) { FactoryBot.create_list(:question, 2) }
      let(:question) { questions.first }
      let(:question_response) { json['questions'].first }
      let!(:answers) { FactoryBot.create_list(:answer, 3, question: question) }

      before { get '/api/v1/questions', params: { access_token: access_token.token }, headers: headers }
 
      it "returns 200 ok" do
        expect(response.status).to eq 200
      end

      it "returns list of questions" do
        expect(json['questions'].size).to eq 2
      end
      
      it "returns all public fields" do
        %w[id title body author_id created_at updated_at].each do |attr|
          expect(question_response[attr]).to eq question.send(attr).as_json
        end
      end

      it "contains author object" do
        expect(question_response['author']['id']).to eq question.author.id
      end

      it "contains short title" do
        expect(question_response['short_title']).to eq question.title.truncate(7)
      end

      describe 'answers' do
        let(:answer) { answers.first }
        let(:answer_response) { question_response['answers'].first }

        it "returns list of answers" do
          expect(question_response['answers'].size).to eq 3
        end

        it "returns all public fields" do
          %w[id body author_id created_at updated_at].each do |attr|
            expect(answer_response[attr]).to eq answer.send(attr).as_json
          end
        end
      end
    end
  end
end
