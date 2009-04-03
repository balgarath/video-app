require '../../config/environment'
require 'rubygems'
require 'scrubyt'

Scrubyt.logger = Scrubyt::Logger.new

data = Scrubyt::Extractor.define do
  fetch "http://railscasts.com/episodes/149-rails-engines"
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
                 :user_id => User.find_by_login('rledge21').id,
                 :title => 'Railscast: ' + data[:title],
                 :description => 'Original Video 
from: ' + data[:url] + "<br />" + data[:description],
                 :tag_list => data[:tag] + ', ruby, rails, railscast')

v.convert
      
      ####################FOR FUTURE REFERENCE#####################
 #v = Video.new(:filename => file.original_filename, :content_type => file.content_type, :temp_path => file.path, :user_id => User.find_by_login('rledge21').id, :title => "Mt. High 2009: Faultline's March Update",:description => "original video from: http://mackdawgproductions.com<br />Springtime is in full effect and the Faultline terrain park is firing. If this video doesn't motivate you to get off your butt and head out to Mt. High, well... ", :tag_list => "snowboard, mt high")      
