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

    def self.find_by_name(name)
        @@all.find {|calendar| calendar.name == name}
    end
end