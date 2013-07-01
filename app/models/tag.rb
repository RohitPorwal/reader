class Tag < ActiveRecord::Base
  
  #GEMS USED
  #ACCESSORS
  attr_accessible :name, :sort_id, :sort_order, :user_id
  
  #ASSOCIATIONS
  belongs_to :user
  has_many :tag_entries
  has_many :my_feeds, through: :tag_entries
  
  #NESTED 
  #VALIDATIONS
  validates :user_id, presence: true
  validates :name, presence: true
  
  #CALLBACKS  
  #SCOPES  
  #OTHER METHODS
  #JOBS
  #PRIVATE
  private
  
end
