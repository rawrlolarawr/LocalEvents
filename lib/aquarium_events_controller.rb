class AquariumEventsController
    attr_writer :a

    def initialize(url)
        @a = AquariumEventsScraper.new(url)
    end

    def call
        puts "Events from the Mystic Aquarium"
        puts "What would you like to do?"
        puts "Type 'events' to see the current events or 'exit' to quit"
        menu
    end

    def menu
        input = get_input
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
    end

    def get_input
        input = ""
        input = gets.strip
    end

    def list_events
        @a.calendar.events.each_with_index {|e, i| puts "#{i+1}. #{e.name}"}
        puts "Enter the number of the Event you would like more information about"
        display_event(get_input)
    end

    def display_event(event)
        e = @a.calendar.events[event.to_i - 1]
        puts "#{e.name}"
        puts "#{e.date}"
        puts "#{e.description}"
    end
end