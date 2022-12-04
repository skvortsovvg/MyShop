require 'rails_helper'

RSpec.describe FindForOauth do
  let!(:user) { FactoryBot.create(:user) }
  let(:auth) { OmniAuth::AuthHash.new(provider: 'vk', uid: '123456') }
  subject { FindForOauth.new(auth) }

  context 'user has authorization' do
    it 'return user' do
      user.authorizations.create(provider: 'vk', uid: '123456')
      expect(subject.call).to eq user
    end
  end
  context 'user has not authorization' do
    context 'user exist' do
      let(:auth) { OmniAuth::AuthHash.new(provider: 'vk', uid: '123456', info: { email: user.email }) }
      it 'does not create new user' do
        expect { subject.call.to_not change(User, :count) }
      end
      it 'add authorization for user' do
        expect { subject.call.to change(user.authorizations, :count).by(1) }
      end
      it 'creates authorization for user' do
        authorization = subject.call.authorizations.first
        expect(authorization.provider).to eq auth.provider
        expect(authorization.uid).to eq auth.uid
      end
      it 'returns user' do
        expect(subject.call).to eq user
      end
    end

    context 'user does not exist' do
      let(:auth) { OmniAuth::AuthHash.new(provider: 'vk', uid: '123456', info: { email: "new_user@email.com" }) }
      it 'creates new user' do
        expect { subject.call.to change(User, :count).by(1) }
      end
      it 'return new user' do
        expect(subject.call).to be_a(User)
      end
      it 'fills user email' do
        expect(subject.call).to eq auth.email
      end
      it 'creates authorization for user' do
        expect(subject.call.authorizations).to_not be_empty
      end
      it 'returns authorization with provider and uid' do
        authorization = subject.call.authorizations.first
        expect(authorization.provider).to eq auth.provider
        expect(authorization.uid).to eq auth.uid
      end
    end 
  end
end
