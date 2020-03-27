class Calendar

    attr_accessor :name, :url

    def initialize(name, url)
        @name, @url = name, url
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