class LocalEvents::Scraper
    # Main Method

    # Scrapes the webpage from the url in the Calendar passed in
    def self.scrape_calendar(calendar)
        if calendar.name == "Mystic Aquarium"
            calendar.doc = Nokogiri::HTML(open(calendar.url))
            scrape_calendar_content(calendar)
        elsif calendar.name == "Niantic Children's Museum"
            calendar.doc = Nokogiri::HTML(open(calendar.url))
            scrape_calendar_content(calendar)
        end
    end

    # Calendar Methods

    # Scrapes the links and names of the events for the Calendar
    def self.scrape_calendar_content(calendar)
        calendar.event_links = calendar.doc.css(calendar.css_calendar_tags).map {|link| link['href']}
        calendar.event_names = calendar.doc.css(calendar.css_calendar_tags).map {|name| name.text.strip}
    end

    # Event Methods

    # Scrapes Events from the current calendar and returns the attributes in an array of hashes
    def self.scrape_events(current_calendar)
        current_calendar.event_links.collect.with_index do |link, i|
            attributes = {name: current_calendar.event_names[i], url: link, calendar: current_calendar}
        end
    end

    # Scrapes description, date, and time from the Event link attribute
    def self.scrape_event_details(event)
        event_page = Nokogiri::HTML(open(event.url))
        event.description = event_page.css(event.calendar.css_event_desc_tags).first.text
        event.date = event_page.css(event.calendar.css_event_date_time_tags).first.text.split(" @ ").first
        event.time = event_page.css(event.calendar.css_event_date_time_tags).first.text.split(" @ ").last
    end
end