require 'rubygems'
require 'scrubyt'

data = Scrubyt::Extractor.define do
	fetch 'http://railscasts.com/episodes/archive'
	
	link "/html/body/div/div[2]/div/div/a" do
		title "/html/body/div/div[2]/div/div/a"
		url("href", { :type => :attribute })	
	end
end

data = data.to_hash
urls = []
for u in data do
	d = "http://www.railscasts.com" + u[:url]
	urls << d
end

for u in urls do
	data = Scrubyt::Extractor.define do
	        fetch u

	        video "//div[@class='main']" do
	                title "/h2"
	                description "/div[@class='description']"
	        end
	end
	puts data.to_xml
	
end
