require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { FactoryBot.create(:question) }
  let(:user) { FactoryBot.create(:user) }

  before { sign_in(user) }

  describe "GET /index" do
    let(:questions) { FactoryBot.create_list(:question, 3) }
    before { get :index }

    it 'returns http success' do
      expect(assigns(:questions)).to match_array(questions)
    end
    it 'check for render index' do
      expect(response).to render_template :index
    end
  end

  describe "GET /new" do
    before { get :new }

    it 'check for new question' do
      expect(assigns(:question)).to be_a_new(Question)
    end
    
    it 'check for new links' do
      expect(assigns(:question).links.first).to be_a_new(Link)
    end

    it 'check for render new' do
      expect(response).to render_template :new
    end
  end

  describe "POST /create" do
    context 'valid question' do
      it 'check for create valid question' do
        expect { post :create, params: { question: { title: '123', body: 'texxt' } } }.to change(Question, :count).by(1)
      end
      it 'check for render new question' do
        post :create, params: { question: { title: '123', body: 'texxt' } }
        expect(response).to redirect_to question_path(Question.last)
      end
    end
  end

  describe "PATCH /update" do
    context 'valid changes' do
      it "succeed" do
        patch :update, params: { id: question.id, question: { body: 'new text question' } }, format: :js
        question.reload
        expect(question.body).to eq 'new text question'
      end
      it 'render changes to view' do
        patch :update, params: { id: question.id, question: { body: 'new text question' } }, format: :js
        expect(response).to render_template :update
      end
    end
    context 'invalid changes' do
      it "error" do
        expect { patch :update, params: { id: question.id, question: FactoryBot.attributes_for(:question, :invalid_question) }, format: :js }.to_not change(question, :body)
      end
      it 'render with errors' do
        patch :update, params: { id: question.id, question: FactoryBot.attributes_for(:question, :invalid_question) }, format: :js
        expect(response).to render_template :update
      end
    end
  end

  describe "POST /delete" do
    let(:question) { FactoryBot.create(:question) }
    it "tries to delete not user's question" do
      expect { delete :destroy, params: { id: question } }.to change(Question, :count).by(1)
    end
    it 'tries to delete own question' do
      sign_in(question.author)
      expect { delete :destroy, params: { id: question } }.to change(Question, :count).by(-1)
    end
  end

  context 'invalid question' do
    it 'check for invalid question' do
      expect { post :create, params: { question: { title: '123', body: nil } } }.to_not change(Question, :count)
    end
    it 'render question form with error' do
      post :create, params: { question: { title: '123', body: nil } }
      expect(response).to render_template :new
    end
  end
end
