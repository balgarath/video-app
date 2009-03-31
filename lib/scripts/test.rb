require '../../config/environment'
require 'rubygems'
require 'scrubyt'

Scrubyt.logger = Scrubyt::Logger.new

data = Scrubyt::Extractor.define do
  fetch "http://feeds2.feedburner.com/railscasts"
  video "//item" do
    title '/title'
    
  end
end

puts data.to_xml

