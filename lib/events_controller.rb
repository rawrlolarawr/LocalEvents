class LocalEvents::EventsController
    include Printable::InstanceMethods
    include Checkable::InstanceMethods
    include Getable::InstanceMethods

    # Source Constants

    MYSTIC = {name: "Mystic Aquarium", url: "https://www.mysticaquarium.org/events/", css_calendar_tags: 'h2.tribe-events-list-event-title a', css_event_desc_tags: 'div.tribe-events-single-event-description p', css_event_date_time_tags: 'span.tribe-event-date-start'}
    NCM = {name: "Niantic Children's Museum", url: "https://www.childrensmuseumsect.org/events/", css_calendar_tags: 'h3.tribe-events-month-event-title a', css_event_desc_tags: 'div.tribe-events-single-event-description p', css_event_date_time_tags: 'span.tribe-event-date-start'}

    # Input Validation Constants

    MENU_RESPONSES = ["events", "source", "exit"]
    SOURCE_RESPONSES = ["1", "2", "exit"]

    # Main Method

    def call
        system("clear")
        puts "Local Events\n\n"
        source_picker
        menu
    end

    # CLI Methods

    # Chooses a source to retrieve events from based on input
    def source_picker
        printer(["Choose a Location", "1. Mystic Aquarium", "2. Niantic Children's Museum"])

        input = get_input
        if valid?(SOURCE_RESPONSES, input)
            case input
            when "1"
                scrape_and_or_set_calendar(MYSTIC)
            when "2"
                scrape_and_or_set_calendar(NCM)
            when "exit"
                quit
            end
        else
            invalid_response(->{source_picker})
        end
    end

    # Displays Events based on source, changes the source, or exits the program based on input
    def menu
        printer(["What would you like to do?", "Type 'events' to see the current events, 'source' to choose a new source or 'exit' to quit"])

        input = get_input
        if valid?(MENU_RESPONSES, input)
            case input
            when "events"
                list_events
                menu
            when "source"
                source_picker
                menu
            when "exit"
                quit
            end
        else
            invalid_response(->{menu})
        end
    end

    # Calendar Methods

    # Checks to see if the calendar instance based on source is created.
    # If it is the method sets the Calendar to that instance if not it scrapes the source and creates the Calendar and its Events.
    def scrape_and_or_set_calendar(source)
        if LocalEvents::Calendar.find_by_name(source[:name])
            @current_calendar = LocalEvents::Calendar.find_by_name(source[:name])
        else
            @current_calendar = LocalEvents::Calendar.new(source)
            LocalEvents::Scraper.scrape_calendar(@current_calendar)
            create_events
        end
    end

    # Event Methods

    # Creates Events based on @current_calendar
    def create_events
        LocalEvents::Scraper.scrape_events(@current_calendar).each {|attributes| LocalEvents::Event.new(attributes)}
    end

    # Lists the events based on the Calendar that was set.
    def list_events
        @current_calendar.events.each_with_index {|event, index| puts "#{index + 1}. #{event.name}"}
        more_information
    end

    # Chooses an event to get more information from based on input
    def more_information
        printer(["Enter the number of the Event you would like more information about", "Enter a number 1-#{@current_calendar.events.length}"])
        input = get_input
        if input.to_i.between?(1, @current_calendar.events.length)
            event = @current_calendar.events[input.to_i - 1]
            populate_and_display_event(event)
        elsif input == "exit"
            quit
        else
            invalid_response(->{more_information})
        end
    end

    # Populates and prints the event that is passed
    def populate_and_display_event(event)
        LocalEvents::Scraper.scrape_event_details(event)
        printer(["#{event.name}", "#{event.date} at #{event.time}\n\n", "#{event.description}", "Website: #{event.url}\n\n"])
    end
end