class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_question, except: %i[index new create]

  def index
    @questions = Question.all
  end

  def new
    @question = current_user.questions.new
    @question.links.new
  end

  def best
    @question.update(best_answer: Answer.find(params[:answer_id]))
    redirect_to question_path(@question)
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  def show
    @question.links.new
    @new_answer = @question.answers.new
    @new_answer.links.new
  end

  def delete_file
    @file_id = params[:file_id]
    @question.files.find_by(id: @file_id).purge
  end

  def delete_link
    @link_id = params[:link_id]
    @question.links.find_by(id: @link_id).destroy
  end

  def update
    @question.update(question_params)
    @question.links.new
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
    @question = Question.with_attached_files.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, files: [], links_attributes: [:id, :name, :url])
  end
end
