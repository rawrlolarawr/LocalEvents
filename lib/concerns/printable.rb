module Printable
    module InstanceMethods
        def invalid_response(method)
            puts "Please enter a valid response"
            method.call
        end
    
        def printer(items)
            items.each {|i| puts i}
        end
    
        def quit
            puts "Goodbye!"
            exit
        end
    end
end