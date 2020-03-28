class Scraper
    attr_accessor :calendar, :doc, :links, :names

    def initialize(name, url)
        @calendar = Calendar.new(name, url)
        @doc = Nokogiri::HTML(open(@calendar.url))
        scrape
    end

    def scrape
        if @calendar.name == "Mystic Aquarium"
            scrape_mystic_calendar_content
        elsif @calendar.name == "Niantic Children's Museum"
            scrape_NCM_calendar_content
        end
        create_events
    end

    def scrape_mystic_calendar_content
        @links = @doc.css('h2.tribe-events-list-event-title a').map {|link| link['href']}
        @names = @doc.css('h2.tribe-events-list-event-title a').map {|name| name.text.strip}
        # @dates = @doc.css('div span.tribe-event-date-start').map {|date| date.text}
    end

    # Not Working Yet!!!
    def scrape_NCM_calendar_content
        @links = @doc.css('h3.tribe-events-month-event-title a').map {|link| link['href']}
        @names = @doc.css('h3.tribe-events-month-event-title a').map {|name| name.text.strip}
    end

    def scrape_event_info(event)
        event_page = Nokogiri::HTML(open(event.url))
        event.description = event_page.css("div.tribe-events-single-event-description p").first.text
        event.date = event_page.css("span.tribe-event-date-start").first.text
    end

    def create_events
        @links.each_with_index do |link, i|
            attributes = {}
            attributes[:name] = @names[i]
            attributes[:url] = link
            # attributes[:date] = @dates[i]
            attributes[:calendar] = @calendar
            event = Event.new(attributes)
        end
    end
end