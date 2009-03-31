require '../../config/environment'
require 'rubygems'
require 'scrubyt'

Scrubyt.logger = Scrubyt::Logger.new

railscasts_data = Scrubyt::Extractor.define do
  fetch 'http://railscasts.com/episodes/archive'

  result_link "Beginning with Cucumber"
  
end

puts railscasts_data.to_xml


