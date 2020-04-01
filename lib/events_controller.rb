class EventsController
    #Input Validation Constants

    MENU_RESPONSES = ["events", "source", "exit"]
    SOURCE_RESPONSES = ["1", "2", "exit"]

    def initialize
        @scraper = Scraper.new
    end

    #Main Method

    def call
        puts "\n\n\n\n\n\nLocal Events\n\n"
        source_picker
        menu
    end

    #CLI Methods

    def source_picker
        printer(["Choose a Location", "1. Mystic Aquarium", "2. Niantic Children's Museum"])

        input = get_input
        if valid?(SOURCE_RESPONSES, input)
            case input
            when "1"
                scrape_and_or_set_calendar("Mystic Aquarium")
            when "2"
                scrape_and_or_set_calendar("Niantic Children's Museum")
            when "exit"
                quit
            end
        else
            invalid_response
            source_picker
        end
    end

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
            invalid_response
            menu
        end
    end

    #Calendar Methods

    def scrape_and_or_set_calendar(name)
        if Calendar.find_by_name(name)
            @current_calendar = Calendar.find_by_name(name)
        else
            @scraper.scrape(name)
            scrape_and_or_set_calendar(name)
        end
    end

    #Event Methods

    def list_events
        @current_calendar.event_list.each_with_index {|event, index| puts "#{index + 1}. #{event.name}"}
        more_information
    end

    def more_information
        printer(["Enter the number of the Event you would like more information about", "Enter a number 1-#{@current_calendar.event_list.length}"])
        input = get_input
        if input.to_i.between?(1, @current_calendar.event_list.length)
            event = @current_calendar.event_list[input.to_i - 1]
            populate_and_display_event(event)
        elsif input == "exit"
            quit
        else
            invalid_response
            more_information
        end
    end

    def populate_and_display_event(event)
        @scraper.scrape_event_info(event)
        printer(["#{event.name}", "#{event.date} at #{event.time}\n\n", "#{event.description}", "Website: #{event.url}\n\n"])
    end
    
    #Shortcut Methods

    def get_input
        input = gets.strip.downcase
    end

    def valid?(valid_answers, input)
        valid_answers.any?(input)
    end

    def invalid_response
        puts "Please enter a valid response"
    end

    def printer(items)
        items.each {|i| puts i}
    end

    def quit
        puts "Goodbye!"
        exit
    end
end