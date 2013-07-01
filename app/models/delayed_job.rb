class DelayedJob < ActiveRecord::Base
  
  #GEMS USED
  #ACCESSORS
  #ASSOCIATIONS
  #VALIDATIONS
  #CALLBACKS
  #SCOPES
  scope :bug,       where("last_error is not null")
  scope :ok,        where("last_error is null")
  scope :active,    where("locked_at is not null")
  
  #CUSTOM SCOPES  
  #OTHER METHODS  
  
  def func
    if !handler.to_s.index("ruby/struct:Dj1").blank?
      return "Refresh"
    elsif !handler.to_s.index("ruby/struct:Dj3").blank?
      return "Unsubscribe"
    end
  end
  
  def status
    if !last_error.blank?
      return "<span class='red'>Error</span>".html_safe
    elsif last_error.blank? and locked_at.blank?
      return "<span style='color: orange;'>In Queue</span>".html_safe
    elsif last_error.blank? and !locked_at.blank?
      return "<span class='green'>Running</span>".html_safe
    end
  end
  
  def user
    if !handler.to_s.index("uid: ").blank?
      a = handler.to_s.split("\n")
      if !a.blank?
        if !a[1].blank?
          akid = a[1].gsub("uid: ", "").gsub("'", "")
          if !akid.blank? and akid != "0" and akid.to_i != 0
            begin
              return User.find(akid.to_i)
            rescue
              return nil
            end
          end
        end
      end
    end
    return nil
  end
  
  def my_feed
    if !handler.to_s.index("akid: ").blank? or !handler.to_s.index("fhub: ").blank?
      a = handler.to_s.split("\n")
      if !a.blank?
        if !a[1].blank?
          akid = a[1].gsub("fhub: ", "").gsub("akid: ", "").gsub("'", "")
          if !akid.blank? and akid != "0" and akid.to_i != 0
            begin
              return Ref::Feed.find(akid.to_i)
            rescue
              return nil
            end
          end
        end
      end
    end
    return nil
  end
  
  #PRIVATE
  private
  
end