require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { FactoryBot.create(:question) }
  let(:answer) { FactoryBot.create(:answer, question) }
  
  describe "GET /new" do
    before { get :new, params: { question_id: question } }

    it 'check for new anwer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'check for render new' do
      expect(response).to render_template(:new)
    end
  end

  describe "POST /create" do
    let(:question) { FactoryBot.create(:question) }
    
    context 'valid answer' do     
      it 'check for create valid answer' do
        expect { post :create, params: { question_id: question, answer: { body: 'texxt' }} }.to change(Answer, :count).by(1) 
      end
      it 'render after create' do
        post :create, params: { question_id: question, answer: { body: 'texxt' }}
        expect(response).to redirect_to("/questions/#{question.id}")
      end
    end

    context 'invalid answer' do
      it 'check for invalid answer' do
        expect { post :create, params: { question_id: question, answer: { body: nil}} }.to_not change(Answer, :count) 
      end      
      it 'render with error' do
        post :create, params: { question_id: question, answer: { body: nil}}
        expect(response).to render_template(:new)
      end
    end    
  end
end
