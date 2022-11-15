class Regard < ApplicationRecord
  belongs_to :question

  scope :users_regards, lambda { |user|
                          # Question.joins("INNER JOIN answers ON answers.id = questions.best_answer_id AND questions.regard_id IS NOT NULL").where('answers.author_id = :author', author: user)
                          Regard.where(question: Question.where(best_answer: Answer.where(author: user)))
                        }
end
