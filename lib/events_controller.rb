class EventsController
    def call
        puts "\n\n\n\n\n\n"
        puts "Local Events\n\n"
        source_picker
        menu
    end

    def source_picker
        puts "Choose a Location"
        puts "1. Mystic Aquarium"
        puts "2. Niantic Children's Museum"
        input = get_input
        if input == "1" || input == "2"
            case input.to_i
            when 1
                if Calendar.find_by_name("Mystic Aquarium")
                    @current_calendar = Calendar.find_by_name("Mystic Aquarium")
                else
                    @mystic_scraper = Scraper.new("Mystic Aquarium", "https://www.mysticaquarium.org/events/")
                    @current_calendar = Calendar.find_by_name("Mystic Aquarium")
                end
            when 2
                if Calendar.find_by_name("Mystic Aquarium")
                    @current_calendar = Calendar.find_by_name("Niantic Children's Museum")
                else
                    @NCM_scraper = Scraper.new("Niantic Children's Museum", "https://www.childrensmuseumsect.org/events/")
                    @current_calendar = Calendar.find_by_name("Niantic Children's Museum")
                end
            end
        else
            puts "Invalid response, please try again."
            menu
        end
    end

    def menu
        puts "What would you like to do?"
        puts "Type 'events' to see the current events, 'source' to choose a new source or 'exit' to quit"
        input = get_input
        if input == "events" || input == "exit" || input == "source"
            case input
            when "events"
                list_events
                menu
            when "source"
                source_picker
                menu
            when "exit"
                exit
            end
        else
            puts "Please enter a valid response"
            menu
        end
    end

    def list_events
        @current_calendar.event_list.each_with_index {|event, index| puts "#{index + 1}. #{event.name}"}
        puts "Enter the number of the Event you would like more information about"
        input = get_input
        if input.to_i.between?(1, @current_calendar.event_list.length)
            event = @current_calendar.event_list[input.to_i - 1]
            populate_event(event)
            display_event(event)
        else
            puts "Please enter a valid response"
            list_events
        end
    end

    def populate_event(event)
        if @current_calendar.name == "Mystic Aquarium"
            @mystic_scraper.scrape_event_info(event)
        elsif @current_calendar.name == "Niantic Children's Museum"
            @NCM_scraper.scrape_event_info(event)
        end
    end

    def display_event(event)
        puts "\n\n\n"
        puts "#{event.name}\n\n"
        puts "#{event.date}\n\n"
        puts "#{event.description}"
        puts "Website: #{event.url}\n\n"
    end
    
    def get_input
        input = gets.strip.downcase
    end

    def exit
        puts "Goodbye!"
    end
end