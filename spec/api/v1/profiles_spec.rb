require 'rails_helper'

describe "Profiles API", type: :request do
  let(:headers) { { "CONTENT_TYPE" => "application/json",
                    "ACCEPT" => "application/json"} }

  describe "GET /api/v1/profiles/me" do
    context 'unauthorized' do
      it "returns 401 if has not access_token" do
        get '/api/v1/profiles/me', headers: headers
        expect(response.status).to eq 401
      end

      it "returns 401 if access_token is invalid" do
        get '/api/v1/profiles/me', params: { access_token: "123" }, headers: headers
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:me) { FactoryBot.create(:user) }
      let(:access_token) { FactoryBot.create(:access_token, resource_owner_id: me.id) }
      
      before { get '/api/v1/profiles/me', params: { access_token: access_token.token }, headers: headers }
 
      it "returns 200 ok" do
        expect(response.status).to eq 200
      end

      it "returns all public fields" do
        # data = JSON.parse(response.body)
        %w[id email admin created_at updated_at].each do |attr|
          expect(json[attr]).to eq me.send(attr).as_json
        end
      end

      it "does not return private fields" do
        # data = JSON.parse(response.body)
        %w[password encrypted_password].each do |attr|
          expect(json).to_not have_key(attr)
        end
      end
    end
  end

   describe "GET /api/v1/profiles/users" do
    context 'unauthorized' do
      it "returns 401 if has not access_token" do
        get '/api/v1/profiles/users', headers: headers
        expect(response.status).to eq 401
      end

      it "returns 401 if access_token is invalid" do
        get '/api/v1/profiles/users', params: { access_token: "123" }, headers: headers
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:me) { FactoryBot.create(:user) }
      let(:access_token) { FactoryBot.create(:access_token, resource_owner_id: me.id) }
      
      before { get '/api/v1/profiles/users', params: { access_token: access_token.token }, headers: headers }
 
      it "returns 200 ok" do
        expect(response.status).to eq 200
      end

      it "returns all public fields" do
        %w[id email].each do |attr|
          expect(json[attr]).to_not eq me.send(attr).as_json
        end
      end

      it "does not return private fields" do
        data = JSON.parse(response.body)
        %w[password encrypted_password].each do |attr|
          expect(json).to_not have_key(attr)
        end
      end
    end
  end
end
