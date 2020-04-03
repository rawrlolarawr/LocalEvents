class Calendar < DataContainer
    extend Findable::ClassMethods

    attr_accessor :css_calendar_tags, :event_names, :event_links, :doc

    def event_list
        Event.all.select {|event| event.calendar == self}
    end
end