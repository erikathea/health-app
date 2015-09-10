# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!
Time::DATE_FORMATS[:formatted_datetime] = "%Y-%m-%d"
Time::DATE_FORMATS[:date_conducted] = "%B %d, %Y"
