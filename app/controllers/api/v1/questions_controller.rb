class Api::V1::QuestionsController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token
  def index
    @questions = Question.all
    render json: @questions
  end
  def show
    render json: Question.find(params[:id]), serializer: SingleQuestionSerializer
  end
  def create
    Question.create(JSON.parse(request.body)) if Ability.new(current_user_owner).can? :create, Question
  end
  def update
    question = Question.find(params[:id])
    render json: question.update(JSON.parse(request.body)) if Ability.new(current_user_owner).can? :update, question
  end
  def destroy
    question = Question.find(params[:id])
    question.destroy if Ability.new(current_user_owner).can? :destroy, question
  end
end