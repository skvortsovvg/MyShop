class Answer < ApplicationRecord
  validates :body, :question_id, presence: true
end
