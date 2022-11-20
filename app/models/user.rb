class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :questions, class_name: "Question", foreign_key: "author_id"
  has_many :answers, class_name: "Answer", foreign_key: "author_id"
  has_many :votes
  has_many :voted_answers, through: :votes, source: :answer
end
