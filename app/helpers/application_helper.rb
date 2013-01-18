module ApplicationHelper
  def print_date(datetime)
    if datetime.nil? 
      return "N/A"
    else
      return "#{datetime.day}/#{datetime.month}/#{datetime.year}"
    end
  end
  
  def print_date_input(datetime)
    if datetime.nil? 
      return ""
    else
      return "#{datetime.day}/#{datetime.month}/#{datetime.year}"
    end
  end
end
