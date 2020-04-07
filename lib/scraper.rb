class LocalEvents::Scraper
    #Source Constants
    
    MYSTIC = {name: "Mystic Aquarium", url: "https://www.mysticaquarium.org/events/", css_calendar_tags: 'h2.tribe-events-list-event-title a', css_event_desc_tags: 'div.tribe-events-single-event-description p', css_event_date_time_tags: 'span.tribe-event-date-start'}
    NCM = {name: "Niantic Children's Museum", url: "https://www.childrensmuseumsect.org/events/", css_calendar_tags: 'h3.tribe-events-month-event-title a', css_event_desc_tags: 'div.tribe-events-single-event-description p', css_event_date_time_tags: 'span.tribe-event-date-start'}

    #Main Method

    # Creates a Calendar instance based on the source passed
    # Scrapes the webpage from the url in the Calendar created
    def self.scrape(source)
        if source == "Mystic Aquarium"
            calendar = LocalEvents::Calendar.new(MYSTIC)
            calendar.doc = Nokogiri::HTML(open(calendar.url))
            scrape_calendar_content(calendar)
        elsif source == "Niantic Children's Museum"
            calendar = LocalEvents::Calendar.new(NCM)
            calendar.doc = Nokogiri::HTML(open(calendar.url))
            scrape_calendar_content(calendar)
        end
        create_events(calendar)
    end

    # Calendar Methods

    # Scrapes the links and names of the events for the Calendar
    def self.scrape_calendar_content(calendar)
        calendar.event_links = calendar.doc.css(calendar.css_calendar_tags).map {|link| link['href']}
        calendar.event_names = calendar.doc.css(calendar.css_calendar_tags).map {|name| name.text.strip}
    end

    #Event Methods

    # Creates Event instances based on the names and links from the Calendar
    def self.create_events(current_calendar)
        current_calendar.event_links.each_with_index do |link, i|
            attributes = {name: current_calendar.event_names[i], url: link, calendar: current_calendar}
            LocalEvents::Event.new(attributes)
        end
    end

    # Scrapes description, date, and time from the Event link attribute
    def self.scrape_event_info(event)
        event_page = Nokogiri::HTML(open(event.url))
        event.description = event_page.css(event.calendar.css_event_desc_tags).first.text
        event.date = event_page.css(event.calendar.css_event_date_time_tags).first.text.split(" @ ").first
        event.time = event_page.css(event.calendar.css_event_date_time_tags).first.text.split(" @ ").last
    end
end