class AquariumEventsController
    attr_writer :a

    def initialize(url)
        @aquarium_scraper = AquariumEventsScraper.new(url)
    end

    def call
        puts "\n\n\n\n\n\n"
        puts "Events from the Mystic Aquarium\n\n"
        puts "What would you like to do?"
        puts "Type 'events' to see the current events or 'exit' to quit"
        menu
    end

    def menu
        input = get_input.downcase
        if input == "events" || input == "exit"
            while input != "exit"
                case input
                when "events"
                    list_events
                    puts "what would you like to do? 'events' for the list of events again or 'exit' to quit"
                    input = get_input
                when "exit"
                    puts "Goodbye!"
                    break
                end
            end
        else
            puts "Please enter a valid response"
            menu
        end
    end

    def get_input
        input = ""
        input = gets.strip
    end

    def list_events
        @aquarium_scraper.calendar.events.each_with_index {|e, i| puts "#{i+1}. #{e.name}"}
        puts "Enter the number of the Event you would like more information about"
        input = get_input.to_i
        if input.between?(1, @aquarium_scraper.calendar.events.length)
            event = @aquarium_scraper.calendar.events[input - 1]
            populate_event(event)
            display_event(event)
        else
            puts "Please enter a valid response"
            list_events
        end
    end

    def populate_event(event)
        @aquarium_scraper.scrape_event_info(event)
    end

    def display_event(event)
        puts "\n\n\n"
        puts "#{event.name}"
        puts "#{event.date}"
        puts "#{event.description}"
    end
end