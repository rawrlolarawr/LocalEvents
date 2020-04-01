class Scraper
    #Source Constants
    
    MYSTIC = {name: "Mystic Aquarium", url: "https://www.mysticaquarium.org/events/", css_calendar_tags: 'h2.tribe-events-list-event-title a'}
    NCM = {name: "Niantic Children's Museum", url: "https://www.childrensmuseumsect.org/events/", css_calendar_tags: 'h3.tribe-events-month-event-title a'}

    attr_accessor :calendar, :doc, :links, :names

    #Main Method

    def scrape(source)
        if source == "Mystic Aquarium"
            @calendar = Calendar.new(MYSTIC)
            @doc = Nokogiri::HTML(open(@calendar.url))
            scrape_calendar_content(@calendar.css_calendar_tags)
        elsif source == "Niantic Children's Museum"
            @calendar = Calendar.new(NCM)
            @doc = Nokogiri::HTML(open(@calendar.url))
            scrape_calendar_content(@calendar.css_calendar_tags)
        end
        create_events
    end

    # Calendar Methods

    def scrape_calendar_content(tags)
        @links = @doc.css(tags).map {|link| link['href']}
        @names = @doc.css(tags).map {|name| name.text.strip}
    end

    #Event Methods

    def create_events
        @links.each_with_index do |link, i|
            attributes = {}
            attributes[:name] = @names[i]
            attributes[:url] = link
            attributes[:calendar] = @calendar
            event = Event.new(attributes)
        end
    end

    def scrape_event_info(event)
        event_page = Nokogiri::HTML(open(event.url))
        event.description = event_page.css("div.tribe-events-single-event-description p").first.text
        event.date = event_page.css("span.tribe-event-date-start").first.text
    end
end