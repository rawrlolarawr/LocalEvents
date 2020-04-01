module DataObjects
    module ClassMethods
        def find_by_name(name)
            self.all.find {|object| object.name == name}
        end
    end

    module InstanceMethods
        def initialize(attributes)
            attributes.each {|key, value| self.send(("#{key}="), value)}
            self.class.all << self
        end
    end
end