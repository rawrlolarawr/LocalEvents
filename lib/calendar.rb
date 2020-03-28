class Calendar

    attr_accessor :name, :url, :events

    def initialize(name, url)
        @name, @url = name, url
        @events = []
    end

    def events
        Event.all.select {|event| event.calendar == self}
    end

    # def events=(event)
    #     if event.is_a?(Event)
    #         @events << event
    #     end
    # end
end