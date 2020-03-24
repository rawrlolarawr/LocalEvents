class AquariumEventsScraper
    attr_accessor :calendar, :doc, :links

    def initialize(url)
        @calendar = Calendar.new
        @doc = Nokogiri::HTML(open(url))
        scrape
    end

    def scrape
        get_links
        scrape_events
    end

    def scrape_events
        @links.each do |link|
            event_page = Nokogiri::HTML(open(link))
            #:name, :date, :description
            attributes = {}
            attributes[:name] = event_page.css("h1.tribe-events-single-event-title").text
            attributes[:date] = event_page.css("h2 span.tribe-event-date-start").text
            attributes[:description] = event_page.css("div.tribe-events-single-event-description p").first.text
            e = Event.new(attributes)
            @calendar.events = e
        end
    end

    def get_links
        @links = @doc.css('h2.tribe-events-list-event-title a').map {|link| link['href']}
    end
end