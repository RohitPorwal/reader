class Ref::Feed < ActiveRecord::Base
  
  #GEMS USED
  #ACCESSORS
  attr_accessible :app_url, :entity_name, :is_pending, :last_processed, :last_requested_processing, :incoming_channel, :rss_last_modified_at, :html_url
  
  attr_accessor :incoming_channel
    
  #ASSOCIATIONS
  has_many    :entries   , dependent: :destroy, class_name: "Ref::Entry"
  has_many    :my_feeds, dependent: :destroy
  
  #VALIDATIONS
  validates :app_url, :format => URI::regexp(%w(http https)), :presence => true, :uniqueness => { case_sensitive: false }, :length => { :minimum => 11 }
  
  #CALLBACKS
  before_create :before_create_set
  after_create :after_create_set
  
  #SCOPES
  #CUSTOM SCOPES
  #OTHER METHODS
    
  def to_s
    self.entity_name
  end
  
  def self.sanitise_url(a)
    if !a.blank?
      return a.gsub("feed/http://", "http://").gsub("feed/https://", "http://").gsub("https://", "http://")
    end
    return a
  end
      
  #JOBS
  #PRIVATE
  
  private
  
  def after_create_set
    Delayed::Job.enqueue Job::Dj1.new(self.id)
    true
  end
  
  def before_create_set
    self.app_url = Ref::Feed.sanitise_url(self.app_url)
    self.entity_name = URI(self.app_url).host if self.entity_name.blank?
  	self.last_requested_processing = Time.now
  	self.last_processed = nil
  	#self.html_url = "http://" + URI(self.app_url).host if self.html_url.blank?
  	true
  end
    
end
