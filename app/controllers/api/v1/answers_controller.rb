class Api::V1::AnswersController < Api::V1::BaseController
  def index
    @question = Question.find(params[:question_id])
    render json: @question.answers
  end
  def show
    render json: Answer.find(params[:id]), serializer: SingleAnswerSerializer
  end
  def create
    Answer.create(JSON.parse(request.body)) if current_user_owner.can? :create, Answer
  end
  def update
    @answer = Answer.find(params[:id])
    @answer.update(JSON.parse(request.body)) if current_user_owner.can? :update, @answer
  end
  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy if current_user_owner.can? :destroy, @answer
  end
end