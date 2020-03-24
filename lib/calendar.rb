class Calendar
    
    def initialize
        @events = []
    end

    def events
        @events.dup.freeze
    end

    def events=(event)
        if event.is_a?(Event)
            @events << event
        end
    end
end