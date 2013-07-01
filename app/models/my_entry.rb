class MyEntry < ActiveRecord::Base
  
  # CONSTANTS
  STARS = ['star0', 'star1', 'star2', 'star3', 'star4', 'star5', 'star6',
           'star7', 'star8', 'star9', 'star10', 'star11', 'star12']

  #GEMS USED
  #ACCESSORS
  attr_accessible :categories, :current_star, :entry_id, :is_star, :is_to_read, :last_clicked_on, :last_starred_at, :user_id, :my_feed_id, :published_at
  
  #ASSOCIATIONS
  belongs_to :entry, class_name: "Ref::Entry"
  belongs_to :user
  belongs_to :my_feed
  
  #VALIDATIONS
  validates :entry_id, presence: true
  validates :user_id, presence: true
  validates :my_feed_id, presence: true
  
  #CALLBACKS
  before_create :before_create_set
  before_save   :before_save_set
  
  #SCOPES
  default_scope order: 'my_entries.published_at DESC'
  scope :read,    where("last_clicked_on is not null")
  scope :to_read, where(is_to_read: true)
  scope :star,    where(is_star: true)
  
  #CUSTOM SCOPES  
  
  def self.by_user(uid)
    where(user_id: uid)
  end
  
  #OTHER METHODS
  
  def guid
    self.entry.guid
  end
  
  def name
    self.entry.name
  end
  
  def summary
    self.entry.summary
  end
  
  def url
    self.entry.url
  end
  
  def author
    self.entry.author
  end
  
  def content
    self.entry.content
  end
  
  def self.create_and_save(akuid, uid, feid)
    f = MyEntry.where(user_id: uid, entry_id: feid, my_feed_id: akuid).first
    if f.blank?
      f = MyEntry.new(user_id: uid, entry_id: feid, my_feed_id: akuid)
      f.save
    end
    return f
  end
  
  def is_read
    self.last_clicked_on.blank? ? false : true
  end
    
  #PRIVATE
  private
  
  def before_create_set
    self.published_at = self.entry.published_at
    true
  end
  
  def before_save_set
    self.current_star = "star0" if self.current_star.blank?
    self.is_star = false        if self.current_star.eql? "star0"
    true
  end
  
end
