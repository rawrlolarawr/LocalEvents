module Findable
    module ClassMethods
        def find_by_name(name)
            self.all.find {|object| object.name == name}
        end
    end
end