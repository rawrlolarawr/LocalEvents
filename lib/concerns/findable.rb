module Findable
    module ClassMethods

        # Finds an Object from the class All variable by its name attribute and returns the Object
        def find_by_name(name)
            self.all.find {|object| object.name == name}
        end
    end

    module InstanceMethods

        def description?
            !!self.description
        end
    end
end