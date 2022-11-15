class Link < ApplicationRecord
  validates :name, :url, presence: true
  validates :url, url: true
end
