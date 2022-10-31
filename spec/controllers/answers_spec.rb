require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { FactoryBot.create(:question) }
  let(:answer) { FactoryBot.create(:answer, question:) }
  let(:user) { FactoryBot.create(:user) }
  before { sign_in(user) }

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
    context 'valid answer' do
      it 'check for create valid answer' do
        expect { post :create, params: { question_id: question, answer: { body: 'texxt' }, format: :js } }.to change(Answer, :count).by(1)
      end
      it 'render after create' do
        post :create, params: { question_id: question, answer: { body: 'texxt' }, format: :js }
        expect(response).to render_template :create
      end
    end

    context 'invalid answer' do
      it 'check for invalid answer' do
        expect { post :create, params: { question_id: question, answer: { body: nil }, format: :js } }.to_not change(Answer, :count)
      end
      it 'render with error' do
        post :create, params: { question_id: question, answer: { body: nil },  format: :js }
        expect(response).to render_template :create
      end
    end
  end

   describe "PATCH /update" do
    context 'valid changes' do
      it "succeed" do
        patch :update, params: { question_id: question, id: answer.id, answer: { body: 'new text' } }, format: :js
        answer.reload
        expect(answer.body).to eq 'new text'
      end
      it 'render changes to view' do
        patch :update, params: { question_id: question, id: answer.id, answer: { body: 'new text' } }, format: :js
        expect(response).to render_template :update
      end
    end
    context 'invalid changes' do
      it "error" do
        expect { patch :update, params: { question_id: question, id: answer.id, answer: FactoryBot.attributes_for(:answer, :invalid) }, format: :js }.to_not change(answer, :body)
      end
      it 'render errors to view' do
        patch :update, params: { question_id: question, id: answer.id, answer: FactoryBot.attributes_for(:answer, :invalid) }, format: :js
        expect(response).to render_template :update
      end
    end
  end

  describe "POST /delete" do
    context 'deleting' do
      it "tries to delete not user's answer" do
        expect { delete :destroy, params: { question_id: question, id: answer.id }, format: :js }.to change(Answer, :count).by(1)
      end
      it 'tries to delete own answer' do
        sign_in(answer.author)
        expect { delete :destroy, params: { question_id: question, id: answer.id }, format: :js }.to change(Answer, :count).by(-1)
      end
    end
  end
end
