class Bookmark < ActiveRecord::Base
  belongs_to :domain
  # has_many :tags
  # accepts_nested_attributes_for :tags
  default_scope -> { order('created_at DESC') }
  
  before_save :create_domain
  
  # before_save { url.downcase! }
  
  validates :url, presence: true,
                  format:   { with: URI.regexp },
                  on: :create
  # validates :domain_id, presence: true

  private
   def create_domain
     domain_name = URI.parse(url).host
     self.domain = Domain.where(name: domain_name).first_or_create
   end
end
