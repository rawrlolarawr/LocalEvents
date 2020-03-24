class Event
    attr_accessor :name, :date, :description

    @@all = []
    def initialize(attributes)
        attributes.each {|key, value| self.send(("#{key}="), value)}
        save
    end

    def save
        @@all << self
    end

    def self.all
        @@all
    end
end