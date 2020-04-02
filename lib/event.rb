class Event < DataContainer
    extend Findable::ClassMethods
    
    attr_accessor :date, :time, :description, :calendar
end