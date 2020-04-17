class LocalEvents::Event < LocalEvents::DataContainer
    extend Findable::ClassMethods
    include Findable::InstanceMethods
    
    attr_accessor :date, :time, :description, :calendar
end