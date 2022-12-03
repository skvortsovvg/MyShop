require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  describe '.find_for_oauth' do
    let!(:user) { FactoryBot.create(:user) }

    context 'user has authorization' do
      let(:auth) { OmniAuth::AuthHash.new(provider: 'vk', uid: '123456') }
      it 'return user' do
        user.authorizations.create(provider: 'vk', uid: '123456')
        expect(User.find_for_oauth(auth)).to eq user
      end
    end
    context 'user has not authorization' do
      context 'user exist' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'vk', uid: '123456', info: { email: user.email }) }
        it 'does not create new user' do
          expect { User.find_for_oauth(auth).to_not change(User, :count) }
        end
        it 'add authorization for user' do
          expect { User.find_for_oauth(auth).to change(user.authorizations, :count).by(1) }
        end
        it 'creates authorization for user' do
          authorization = User.find_for_oauth(auth).authorizations.first
          expect(authorization.provider).to eq auth.provider
          expect(authorization.uid).to eq auth.uid
        end
        it 'returns user' do
          expect(User.find_for_oauth(auth)).to eq user
        end
      end

      context 'user does not exist' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'vk', uid: '123456', info: { email: "new_user@email.com" }) }
        it 'creates new user' do
          expect { User.find_for_oauth(auth).to change(User, :count).by(1) }
        end
        it 'return new user' do
          expect(User.find_for_oauth(auth)).to be_a(User)
        end
        it 'fills user email' do
          user = User.find_for_oauth(auth)
          expect(user.email).to eq auth.email
        end
        it 'creates authorization for user' do
          user = User.find_for_oauth(auth)
          expect(user.authorizations).to_not be_empty
        end
        it 'returns authorization with provider and uid' do
          authorization = User.find_for_oauth(auth).authorizations.first
          expect(authorization.provider).to eq auth.provider
          expect(authorization.uid).to eq auth.uid
        end
      end 
    end
  end
end
