class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.create(body: answer_params[:body], author: current_user)
    # @answer.save

    # if @answer.save
    #   redirect_to question_path(@answer.question)
    # else
    #   render :new
    # end
  end

  def destroy
    @answer = Answer.find(params[:id])
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

  def answer_params
    params.require(:answer).permit(:body)
  end
end
