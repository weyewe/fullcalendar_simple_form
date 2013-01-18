class EventsController < ApplicationController
  # GET /events
  # GET /events.xml
  def index   
    # full_calendar will hit the index method with query parameters
    # 'start' and 'end' in order to filter the results for the
    # appropriate month/week/day.  It should be possiblt to change
    # this to be starts_at and ends_at to match rails conventions.
    # I'll eventually do that to make the demo a little cleaner.
    # @events = Event.scoped  
    # @events = @events.after(params['start']) if (params['start'])
    # @events = @events.before(params['end']) if (params['end'])
    # 
    @events = Event.fullcalendar_events(  Event.format_date(  params['start'] ) , 
                                          Event.format_date(  params['end']   ) )
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
      format.js  { render :json => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
      format.js { render :json => @event.to_json }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new
    @new_object = Event.new 

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
      format.js {}
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    @object = @event 
  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(params[:event])
    
   
    
    @event.starts_at = parse_date( params[:event][:starts_at])
    @event.ends_at  = parse_date( params[:event][:ends_at])
    @event.save 

    @has_any_errors = @event.errors.size 
    @object = @event
     
      @new_object = @object  

    # respond_to do |format|
    #   if @event.save
    #     format.html { redirect_to(@event, :notice => 'Event was successfully created.') }
    #     format.xml  { render :xml => @event, :status => :created, :location => @event }
    #   else
    #     format.html { render :action => "new" }
    #     format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
    #   end
    # end
  end

  # PUT /events/1
  # PUT /events/1.xml
  # PUT /events/1.js
  # when we drag an event on the calendar (from day to day on the month view, or stretching
  # it on the week or day view), this method will be called to update the values.
  # viv la REST!
  def update
    @event = Event.find(params[:id])
     
    @event.starts_at = parse_date( params[:event][:starts_at])
    @event.ends_at  = parse_date( params[:event][:ends_at])
    @event.update_attributes(params[:event])
 
    @has_no_errors = @event.errors.size  == 0 
    
    puts "There is ERROR!!!!" if not @has_any_errors
    puts "THERE IS NOOOO ERROR!" if  @has_no_errors
    
    puts "this is hte error\n"*10
    puts "Total error count: #{@event.errors.size }"
    @event.errors.messages.each do |message|
      puts "THe error message is: #{message}"
    end
    @object = @event 
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
    end
  end
end
