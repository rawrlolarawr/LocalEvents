class Scraper
    #Source Constants
    
    MYSTIC = {name: "Mystic Aquarium", url: "https://www.mysticaquarium.org/events/", css_calendar_tags: 'h2.tribe-events-list-event-title a'}
    NCM = {name: "Niantic Children's Museum", url: "https://www.childrensmuseumsect.org/events/", css_calendar_tags: 'h3.tribe-events-month-event-title a'}

    #Main Method

    def self.scrape(source)
        if source == "Mystic Aquarium"
            calendar = Calendar.new(MYSTIC)
            calendar.doc = Nokogiri::HTML(open(calendar.url))
            scrape_calendar_content(calendar)
        elsif source == "Niantic Children's Museum"
            calendar = Calendar.new(NCM)
            calendar.doc = Nokogiri::HTML(open(calendar.url))
            scrape_calendar_content(calendar)
        end
        create_events(calendar)
    end

    # Calendar Methods

    def self.scrape_calendar_content(calendar)
        calendar.event_links = calendar.doc.css(calendar.css_calendar_tags).map {|link| link['href']}
        calendar.event_names = calendar.doc.css(calendar.css_calendar_tags).map {|name| name.text.strip}
    end

    #Event Methods

    def self.create_events(current_calendar)
        current_calendar.event_links.each_with_index do |link, i|
            attributes = {name: current_calendar.event_names[i], url: link, calendar: current_calendar}
            Event.new(attributes)
        end
    end

    def self.scrape_event_info(event)
        event_page = Nokogiri::HTML(open(event.url))
        event.description = event_page.css("div.tribe-events-single-event-description p").first.text
        event.date = event_page.css("span.tribe-event-date-start").first.text.split(" @ ").first
        event.time = event_page.css("span.tribe-event-date-start").first.text.split(" @ ").last
    end
end