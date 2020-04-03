module Checkable
    module InstanceMethods

        # Takes an array of valid answers and an input and returns true if the input is in the array
        def valid?(valid_answers, input)
            valid_answers.any?(input)
        end
    end
end