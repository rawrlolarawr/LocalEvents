module Printable
    module InstanceMethods
        def invalid_response
            puts "Please enter a valid response"
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