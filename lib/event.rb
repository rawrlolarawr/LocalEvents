class Event
    extend DataObjects::ClassMethods
    include DataObjects::InstanceMethods

    #Class Methods

    @@all = []
    
    def self.all
        @@all
    end

    #Instance Methods

    attr_accessor :name, :date, :time, :description, :calendar, :url
end