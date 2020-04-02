class Calendar < DataContainer
    extend Findable::ClassMethods

    attr_accessor :css_calendar_tags

    def event_list
        Event.all.select {|event| event.calendar == self}
    end
end