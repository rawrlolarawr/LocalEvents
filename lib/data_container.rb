class LocalEvents::DataContainer

    # Keeps track of all instances of DataContainers
    @@all = []
    
    # Returns the instances that are of the Class that called the method
    def self.all
        @@all.select{|c| c.is_a?(self)}
    end

    attr_accessor :name, :url

    def initialize(attributes)
        attributes.each {|key, value| self.send(("#{key}="), value)}
        @@all << self
    end
end