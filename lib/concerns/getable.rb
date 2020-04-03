module Getable
    module InstanceMethods

        # Gets Input, removes whitespace, and converts it to lowercase
        def get_input
            input = gets.strip.downcase
        end
    end
end