class Thumbnail < ActiveRecord::Base
  has_attachment :content_type => :image, 
                 :storage => :file_system                 
  has_one :video
  
  def self.create!(vpath)
	    tpath = vpath + ".jpg"
	    system "ffmpeg -i #{vpath} -ss 20 -s 150x100 -vframes 1 -f image2 -an #{tpath}"
	    t = Thumbnail.new(:filename => File.basename(tpath), :content_type => 'image/jpeg', :temp_path => tpath)
	    t.save ? t : false		
  end
end
