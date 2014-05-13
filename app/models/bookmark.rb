class Bookmark < ActiveRecord::Base
  attr_accessor :tag_list
  belongs_to :domain
  has_many :bookmarks_tags, dependent: :destroy
  has_many :tags, :through => :bookmarks_tags

  default_scope -> { order('created_at DESC') }
  
  before_create :create_domain
  before_create :create_short_url
  before_save   :create_tags
  
  validates :url, presence: true,
                  format:   { with: URI.regexp },
                  on: :create,
                  uniqueness: true

  private
   def create_domain
     domain_name = URI.parse(url).host
     self.domain = Domain.where(name: domain_name).first_or_create
   end

  def create_tags
    tag_array = tag_list.split(',')
    tag_array.each do |tag_name|
      self.tags << Tag.where(name: tag_name.strip).first_or_create
    end
  end

  def create_short_url
    token = "18c57dc7ba4937d30de10f0e0e73a16c17ca29c0"
    api_address = "https://api-ssl.bitly.com"
    
    encoded = URI::escape(url)
    uri = URI.parse("#{api_address}/v3/shorten?" +
                    "access_token=#{token}&longUrl=#{encoded}")
    
    response = Net::HTTP.get(uri)
    self.short_url = ActiveSupport::JSON.decode(response)["data"]["url"]
  end
end
