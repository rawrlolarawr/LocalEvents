module Checkable
    module InstanceMethods
        def valid?(valid_answers, input)
            valid_answers.any?(input)
        end
    end
end