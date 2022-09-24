class AnswersController < ApplicationController
  def index
  end

  def new
    @answer = Question.find(params[:question_id]).answers.new
  end

  def create
    @answer = Answer.create(answer_params)
    if @answer.save
      redirect_to question_path(@answer.question)
    else
      render :new
    end
  end

private
  
  def answer_params
    params.require(:answer).permit(:body).merge({question_id: params[:question_id]})
  end
end