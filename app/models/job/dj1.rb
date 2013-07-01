class Job::Dj1 < Struct.new(:akid)
    
  def perform
    ak = Ref::Feed.find(akid)
    entries = nil
    feed = Feedzirra::Feed.fetch_and_parse(ak.app_url)
    if feed.present?
      if feed.class.to_s != "Fixnum"
        if ak.last_processed.blank? or (((Time.now - ak.last_processed)/3600) > 2 and ak.last_processed.present?) or ak.entries.first.blank?
          #if first_time
            if ak.entity_name.blank? or ak.html_url.blank?
              ak.update_attributes(entity_name: feed.title, html_url: feed.url)
            end
            entries = feed.entries
          #else
            #updated_feed = Feedzirra::Feed.update(feed)
            #if updated_feed.present?
              #if updated_feed.class.to_s != "Fixnum"
                #if updated_feed.first.present?
                  #if updated_feed.updated?
                    #entries = updated_feed.new_entries
                  #end
                #end
              #end
            #end
          #end
          if entries.present?
            entries.each do |entry|
              a = Ref::Entry.where(feed_id: ak.id, guid: entry.id).first
              if a.blank?
                a = Ref::Entry.new(feed_id: ak.id, guid: entry.id, name: entry.title, summary: entry.summary, content: entry.content, url: entry.url, published_at: entry.published.blank? ? Time.now : entry.published, author: entry.author)
                a.save
              end
            end
            if ak.my_feeds.first.present?
              ak.my_feeds.each do |my_f|
                ak.entries.each do |article|
                  MyEntry.create_and_save(my_f.id, my_f.user_id, article.id)
                end
              end
            end
          end
          ak.update_attributes(is_pending: "done", last_processed: Time.now, rss_last_modified_at: feed.last_modified)
        end
      end
    end
  end
  
end