class EventsController
    def initialize(name, url)
        @scraper = Scraper.new(name, url)
    end

    def call
        puts "\n\n\n\n\n\n"
        puts "Local Events\n\n"
        puts "What would you like to do?"
        puts "Type 'events' to see the current events or 'exit' to quit"
        menu
    end

    def menu
        input = get_input
        if input == "events" || input == "exit"
            case input
            when "events"
                list_events
                puts "what would you like to do? 'events' for the list of events again or 'exit' to quit"
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
        @scraper.calendar.event_list.each_with_index {|event, index| puts "#{index + 1}. #{event.date} - #{event.name}"}
        puts "Enter the number of the Event you would like more information about"
        input = get_input
        if input.to_i.between?(1, @scraper.calendar.event_list.length)
            event = @scraper.calendar.event_list[input.to_i - 1]
            populate_event(event)
            display_event(event)
        else
            puts "Please enter a valid response"
            list_events
        end
    end

    def populate_event(event)
        @scraper.scrape_mystic_event_info(event)
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