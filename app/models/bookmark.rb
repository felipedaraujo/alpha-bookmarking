class Bookmark < ActiveRecord::Base
  has_many :tags
  before_save { url.downcase! }
  validates :url, presence: true,
                  format:   { with: URI.regexp }
  accepts_nested_attributes_for :tags
end
