namespace :video do
  require 'rubygems'
  require 'scrubyt'
  
  
  desc "Imports a video from railscasts.com"
  task :railscast, :url, :needs => :environment do |t, args|
    args.with_defaults(:url => nil)
    Scrubyt.logger = Scrubyt::Logger.new
    
    unless args.url.nil?
    
    else
      puts "Error: Must pass in Railscasts URL"
    end #unless

  end #task :railscast
end
