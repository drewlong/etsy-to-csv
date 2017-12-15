require 'csv'
require 'date'
require 'etsy'
require 'yaml'

module EtsyBot
  class Monitor
    def initialize
      config = YAML.load_file(File.dirname(__FILE__)+"/lib/config.yml")
      Etsy.protocol = config[:etsy_protocol]
      Etsy.api_key = config[:etsy_api_key]
      Etsy.api_secret = config[:etsy_api_secret]
    end

    def search(term)
      term = term.downcase
      cats = Etsy::Category.all_top
      @results = []
      cats.each do |cat|
        begin
          name = cat.category_name
          items = Etsy::Listing.find_all_active_by_category(name)
          items.each do |item|
            if item.title.downcase.include? term
              title = item.title.gsub(/([^\w" "])/, "")
              row = [title, item.price, item.url, item.view_count]
              @results << row
              puts title
            end
          end
        rescue
        end
        sleep 1
      end
    end

    def save_csv
      date = DateTime.now.strftime("%Y%m%d-%H%m")
      CSV.open("results-#{date}.csv", "a") do |csv|
        csv << ["Title", "Price", "URL", "View Count"]
        @results.each{|r| csv << r}
      end
    end

  end
end

bot = EtsyBot::Monitor.new
bot.search(ARGV[0])
bot.save_csv
