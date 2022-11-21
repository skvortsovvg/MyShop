class AnswersController < ApplicationController
  before_action :set_question, only: %i[create]
  before_action :set_answer, except: %i[create]

  def create
    @answer = @question.answers.create(answer_params.merge(author: current_user))
  end

  def edit
    @answer.links.new
  end

  def update
    @answer.update(answer_params)
  end

  def like # or dislike
    vote = @answer.current_vote(current_user)
    like = params[:like]

    if !vote
      @answer.votes.create(user: current_user, like:)
    elsif vote.like.to_s == like
      vote.destroy
    else
      vote.update(like:)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json do
        render json: {
          answer_id: @answer.id,
          rating: @answer.rating,
          html: render_to_string(partial: 'answers/likes', locals: { answer: @answer }, formats: [:html])
        }
      end
    end
  end

  def delete_file
    @file_id = params[:file_id]
    @answer.files.find_by(id: @file_id).purge
  end

  def destroy
    if @answer.author == current_user
      @answer.destroy
      # redirect_to question_path(@answer.question), notice: "Answer was successfully deleted."
    else
      @answer.errors.add(:access, "Access denied! Only author can delete it!")
      # redirect_to root_path, alert: "Access denied! Only author can delete it!"
    end
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.with_attached_files.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, files: [], links_attributes: %i[id name url])
  end
end
