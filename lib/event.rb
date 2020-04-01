class Event
    extend Objects::ClassMethods
    include Objects::InstanceMethods

    #Class Methods

    @@all = []
    
    def self.all
        @@all
    end

    #Instance Methods

    attr_accessor :name, :date, :description, :calendar, :url
end