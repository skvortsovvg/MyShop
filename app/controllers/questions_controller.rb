class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question, only: [:show, :destroy]

  def index
    @questions = Question.all
  end

  def new
    @question = current_user.questions.new
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      redirect_to :root
    else
      render :new
    end
  end

  def destroy
    if @question.author == current_user
      @question.destroy
      redirect_to root_path, notice: "Question was successfully deleted."
    else
      redirect_to question_path(@question), alert: "Access dinied! Only author can delete it!"
    end
  end

  private

  def set_question
    @question = Question.find(params[:id]);
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
