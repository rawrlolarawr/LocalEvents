module Printable
    module InstanceMethods

        # Takes a Lambda method as an argument prints invalid response and calls the Lambda       
        def invalid_response(lambda_method)
            puts "Please enter a valid response"
            lambda_method.call
        end
        
        # Prints an array
        def printer(items)
            items.each {|i| puts i}
        end
        
        # Prints Goodbye! and exits the program
        def quit
            puts "Goodbye!"
            exit
        end
    end
end