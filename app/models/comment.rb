class Comment < ApplicationRecord
  include PgSearch
  multisearchable against: [:body]

  after_save :reindex

  belongs_to :author, class_name: "User"

  private

  def reindex
    PgSearch::Multisearch.rebuild(Comment)
  end
end
