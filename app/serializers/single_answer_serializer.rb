class SingleAnswerSerializer < ActiveModel::Serializer
  attributes :id, :body, :author_id, :created_at, :updated_at
  has_many :comments
  has_many :links do
    object.links.map { |link| link.url }
  end
  has_many :files do
    object.files.map { |file| Rails.application.routes.url_helpers.rails_blob_path(file, only_path: true) }
  end
end
