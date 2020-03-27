class AquariumEventsScraper
    attr_accessor :calendar, :doc, :links, :names, :dates

    def initialize(name, url)
        @calendar = Calendar.new(name, url)
        @doc = Nokogiri::HTML(open(@calendar.url))
        scrape
    end

    def scrape
        if @calendar.name == "Mystic Aquarium"
            scrape_mystic_calendar_content
            create_events
        end
    end

    def scrape_mystic_calendar_content
        @links = @doc.css('h2.tribe-events-list-event-title a').map {|link| link['href']}
        @names = @doc.css('h2.tribe-events-list-event-title a').map {|name| name.text.strip}
        @dates = @doc.css('div span.tribe-event-date-start').map {|date| date.text}
    end

    def scrape_mystic_event_info(event)
        event_page = Nokogiri::HTML(open(event.url))
        event.description = event_page.css("div.tribe-events-single-event-description p").first.text
    end

    def create_events
        @links.each_with_index do |link, i|
            attributes = {}
            attributes[:name] = @names[i]
            attributes[:url] = link
            attributes[:date] = @dates[i]
            attributes[:calendar] = @calendar
            event = Event.new(attributes)
            @calendar.events = event
        end
    end
end