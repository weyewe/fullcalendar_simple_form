$(document).ready(function() {

	var date = new Date();
	var d = date.getDate();
	var m = date.getMonth();
	var y = date.getFullYear();
	var events_url = $("#events_url").val(); 
	
	
	$('#calendar').fullCalendar({
		editable: true,        
		header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        defaultView: 'month',
        height: 500,
        slotMinutes: 15,
        
        loading: function(bool){
            if (bool) 
                $('#loading').show();
            else 
                $('#loading').hide();
        },
        
        // a future calendar might have many sources.        
        eventSources: [{
            url: events_url,
            color: 'yellow',
            textColor: 'black',
            ignoreTimezone: false
        }],
        
        timeFormat: '',
        dragOpacity: "0.5",
        
        //http://arshaw.com/fullcalendar/docs/event_ui/eventDrop/
        eventDrop: function(event, dayDelta, minuteDelta, allDay, revertFunc){
            updateEvent(event);
        },

        // http://arshaw.com/fullcalendar/docs/event_ui/eventResize/
        eventResize: function(event, dayDelta, minuteDelta, revertFunc){
            updateEvent(event);
        },

        // http://arshaw.com/fullcalendar/docs/mouse/eventClick/
        eventClick: function(event, jsEvent, view){
          // would like a lightbox here.
			// show the modal.
			// get the content.. // server logic:
			// if it is confirmed, show the summary. else, show the sweet thing
			console.log("Gyayahahaha!! this is awesome shite"); 
			
			var $modal = $("#editEntry");
			$modal.modal('show'); 

			$(".modal_closer", $modal ).click(function(){
				$modal.modal('hide'); 
				$("form", $modal).remove(); 
			});


			var get_form_url =  $(this).attr("href");

			// get the edit form 
			$.ajax({
				url: get_form_url,
				type: "GET",
				// data: $form.serialize(),
				dataType: 'script',
				success: function(response){ 
					// it is live.. ajax-form class
				}
			}); 

			return false; 
        },
	});
});

function updateEvent(the_event) {
    $.update(
      "/events/" + the_event.id,
      { event: { title: the_event.title,
                 starts_at: "" + the_event.start,
                 ends_at: "" + the_event.end,
                 description: the_event.description
               }
      },
      function (reponse) { alert('successfully updated task.'); }
    );
};