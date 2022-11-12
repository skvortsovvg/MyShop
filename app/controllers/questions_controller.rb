class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_question, only: %i[show destroy update best]

  def index
    @questions = Question.all
  end

  def new
    @question = current_user.questions.new
  end

  def best
     @question.update(best_answer: Answer.find(params[:answer_id]))
     redirect_to question_path(@question)
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      redirect_to :root
    else
      render :new
    end
  end

  def update
    @question.update(question_params)
  end

  def destroy
    if @question.author == current_user
      @question.destroy
      redirect_to root_path, notice: "Question was successfully deleted."
    else
      redirect_to question_path(@question), alert: "Access denied! Only author can delete it!"
    end
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, :file)
  end
end
