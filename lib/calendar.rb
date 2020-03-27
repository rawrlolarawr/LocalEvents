class Calendar

    attr_accessor :name

    def initialize(name)
        @name = name
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