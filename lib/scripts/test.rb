require '../../config/environment'
require 'rubygems'
require 'scrubyt'

Scrubyt.logger = Scrubyt::Logger.new

data = Scrubyt::Extractor.define do
  fetch "http://railscasts.com/episodes/154-polymorphic-association"
  video "//div[@class='main']" do
    title '/h2'
    description '/div[@class="description"]'
    tags '/div[@class="tags"]' do
      tag '/a'
    end
    
    video_link '/div[3]/a' do
      url("href", { :type => :attribute })
    end
    
  end
end

data = data.to_hash.first

file = UrlUpload.new(data[:url])

v = Video.create(:filename => file.original_filename, 
                 :content_type => file.content_type, 
                 :temp_path => file.path, 
                 :user_id => User.find_by_login('rledge21'),
                 :title => data[:title],
                 :description => data[:description],
                 :tag_list => data[:tag])

v.convert
      
