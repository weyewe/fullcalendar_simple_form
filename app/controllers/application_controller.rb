class ApplicationController < ActionController::Base
  protect_from_forgery
  
  
  # got these tips from
  # http://lyconic.com/blog/2010/08/03/dry-up-your-ajax-code-with-the-jquery-rest-plugin
  before_filter :correct_safari_and_ie_accept_headers
  after_filter :set_xhr_flash

  def set_xhr_flash
    flash.discard if request.xhr?
  end

  def correct_safari_and_ie_accept_headers
    ajax_request_types = ['text/javascript', 'application/json', 'text/xml']
    request.accepts.sort! { |x, y| ajax_request_types.include?(y.to_s) ? 1 : -1 } if request.xhr?
  end
  
  def parse_date(date)
    return nil if date.nil? or date.length == 0  
    date_array = date.split("/")
    begin
      return Date.new(date_array[2].to_i,date_array[1].to_i,date_array[0].to_i ) 
    rescue ArgumentError
      return nil
    end
  end
  
  
end
