class Calendar < DataContainer
    extend Findable::ClassMethods

    attr_accessor :css_calendar_tags, :css_event_desc_tags, :css_event_date_time_tags, :event_names, :event_links, :doc

    def events
        Event.all.select {|event| event.calendar == self}
    end
end