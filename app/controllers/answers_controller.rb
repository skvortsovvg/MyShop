class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: [:create, :new]
  before_action :set_answer, only: [:edit, :destroy, :update]

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.create(body: answer_params[:body], author: current_user)
  end

  def edit
  end

  def update
    @answer.update(answer_params)
  end

  def destroy
    if @answer.author == current_user
      @answer.destroy
      # redirect_to question_path(@answer.question), notice: "Answer was successfully deleted."
    else
      @answer.errors.add(:access, "Access denied! Only author can delete it!");
      # redirect_to root_path, alert: "Access denied! Only author can delete it!"
    end
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end
  
  def answer_params
    params.require(:answer).permit(:body)
  end
end
