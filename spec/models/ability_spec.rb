require 'rails_helper'

RSpec.describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'guest' do
    let(:user) { nil }

    it { should be_able_to :read, Question }
    it { should be_able_to :read, Answer }
    it { should be_able_to :read, Comment }

    it { should_not be_able_to :manage, :all }
  end

  describe 'admin' do
    let(:user) { FactoryBot.create :user, admin: true }

    it { should be_able_to :manage, :all }
  end

  describe 'registered user' do
    let(:user) { FactoryBot.create :user }
    let(:other_user) { FactoryBot.create :user }    
    
    it { should be_able_to :read, :all }
    it { should_not be_able_to :manage, :all }

    it { should be_able_to :create, Question }
    it { should be_able_to :create, Answer }
    it { should be_able_to :create, Comment }
    
    it { should be_able_to :update, FactoryBot.create(:question, author: user), author: user }
    it { should_not be_able_to :update, FactoryBot.create(:question, author: other_user), author: user }

    it { should be_able_to :update, FactoryBot.create(:answer, author: user), author: user }
    it { should_not be_able_to :update, FactoryBot.create(:answer, author: other_user), author: user }

    it { should be_able_to :update, FactoryBot.create(:comment, author: user), author: user }
    it { should_not be_able_to :update, FactoryBot.create(:comment, author: other_user), author: user }
  end

end
