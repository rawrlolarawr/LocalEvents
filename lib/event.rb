class Event
    attr_accessor :name, :date, :description, :calendar, :url

    @@all = []

    def initialize(attributes)
        attributes.each {|key, value| self.send(("#{key}="), value)}
        save
    end

    def save
        @calendar.events << self
        @@all << self
    end

    def self.all
        @@all
    end
end