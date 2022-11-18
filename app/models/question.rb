class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :author, class_name: "User"
  has_one :best_answer, class_name: "Answer"
  has_one :regard, dependent: :destroy
  has_many :links, dependent: :destroy, as: :linkable

  accepts_nested_attributes_for :links, :regard, reject_if: :all_blank

  has_many_attached :files

  validates :title, :body, presence: true

  scope :answers_best_first, ->(qst) { qst.answers.where(id: qst.best_answer) + qst.answers.where.not(id: qst.best_answer) }
end
