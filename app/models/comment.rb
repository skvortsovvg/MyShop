class Comment < ApplicationRecord
  include PgSearch
  multisearchable against: [:body]

  after_save :reindex

  belongs_to :author, class_name: "User"
  belongs_to :commentable, polymorphic: true, touch: true

  private

  def reindex
    PgSearch::Multisearch.rebuild(Comment)
  end
end
