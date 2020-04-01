class Calendar
    extend Objects::ClassMethods
    include Objects::InstanceMethods

    #Class Methods

    @@all = []

    def self.all
        @@all
    end
    
    #Instance Methods

    attr_accessor :name, :url , :css_calendar_tags

    def event_list
        Event.all.select {|event| event.calendar == self}
    end
end