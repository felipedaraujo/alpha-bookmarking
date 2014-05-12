class Bookmark < ActiveRecord::Base
  attr_reader :list
  
  belongs_to :domain
  has_many :taggings
  has_many :tag, :through => :taggings

  has_and_belongs_to_many :tags
  
  default_scope -> { order('created_at DESC') }
  
  before_create :create_domain
  before_create :create_tags
  
  validates :url, presence: true,
                  format:   { with: URI.regexp },
                  on: :create
  # validates :domain_id, presence: true

  private
   def create_domain
     domain_name = URI.parse(url).host
     self.domain = Domain.where(name: domain_name).first_or_create
   end

  def create_tags
    var = "list, rails, tutor".split(',')
    var.each do |tag_name|
      Tag.where(name: tag_name).first_or_create
    end
  end

  def tagging
    
  end

end
