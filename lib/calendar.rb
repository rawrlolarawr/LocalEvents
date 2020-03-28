class Calendar
    attr_accessor :name, :url

    @@all = []

    def initialize(name, url)
        @name, @url = name, url
        save
    end

    def event_list
        Event.all.select {|event| event.calendar == self}
    end

    def save
        @@all << self
    end

    def self.all
        @@all
    end
end