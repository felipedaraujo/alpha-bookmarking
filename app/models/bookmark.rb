class Bookmark < ActiveRecord::Base
  belongs_to :domain
  has_many :tags
  before_save { url.downcase! }
  validates :url, presence: true,
                  format:   { with: URI.regexp }
  accepts_nested_attributes_for :tags
end
