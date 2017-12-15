# Etsy to CSV
____

This is a simple bot I wrote as a sort of template to use for future projects. I get a lot of requests for Etsy search bots, so this seemed like a good idea. The bot takes a search term, supplied via command line, and searches all top categories for listings that include that term. The bot gathers the item title, price, URL, and view count, and commits the results to a time-coded CSV file. 

To get started, you'll need:
* Linux (Debian/Ubuntu suggested)
* Ruby 2.3+
* An Etsy Account
* Etsy API Key / API Secret

Installation:

1. Run `sudo gem install etsy`
2. Alter `lib/config.yml` with your information
3. Done

To run, simply migrate to the directory root and run `ruby main.rb <search term>` . 

Enjoy!
