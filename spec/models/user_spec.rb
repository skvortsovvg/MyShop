require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  describe '.find_for_oauth' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:auth) { OmniAuth::AuthHash.new(provider: 'vk', uid: '123456') }

    context 'user has authorization' do
      it 'return user' do
        user.authorizations.create(provider: 'vk', uid: '123456')
        expect(User.find_for_oauth(auth)).to eq user
      end
    end
  end
end
