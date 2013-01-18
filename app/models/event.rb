class Event < ActiveRecord::Base
  attr_accessible :title       ,
                  :starts_at   ,
                  :ends_at     ,
                  :all_day     ,
                  :description 
  
  


  scope :before, lambda {|end_time| {:conditions => ["ends_at < ?", Event.format_date(end_time)] }}
  scope :after, lambda {|start_time| {:conditions => ["starts_at > ?", Event.format_date(start_time)] }}
  
  
  
  # need to override the json view to return what full_calendar is expecting.
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
  def as_json(options = {})
    {
      :id => self.id,
      :title => self.title,
      :description => self.description || "",
      :start => starts_at.rfc822,  # "Tue, 11 Dec 2012 17:00:00 +0000" .. we need to give GMT +7 , and give the date 
      :end => ends_at.rfc822,
      :allDay => self.all_day,
      :recurring => false,
      :url => Rails.application.routes.url_helpers.edit_event_path(id),
      :color => EVENT_SOURCE_COLOR[ self.id.to_s[-1].to_i  ][:color] , 
      :textColor =>  EVENT_SOURCE_COLOR[ self.id.to_s[-1].to_i  ][:textColor] 
      
      
    }
    
  end
  
  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end
  
  def self.fullcalendar_events( start_time, end_time )
    self.where{
      ( ends_at.gte start_time ) | 
      ( starts_at.lte end_time )  
    }
  end
end
