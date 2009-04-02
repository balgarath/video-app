class Video < ActiveRecord::Base
	
	acts_as_taggable
	
  belongs_to :thumbnail
	belongs_to :user
	has_many :replies, :class_name => 'VideoReply'
  
  before_create :save_thumbnail

	has_attachment :content_type => :video, 
                 :storage => :file_system, 
                 :max_size => 300.megabytes

  attr_accessor :url

  #acts as state machine plugin
  acts_as_state_machine :initial => :pending
  state :pending
  state :converting
  state :converted, :enter => :set_new_filename
  state :error

  event :convert do
    transitions :from => :pending, :to => :converting
  end

  event :converted do
    transitions :from => :converting, :to => :converted
  end

  event :failure do
    transitions :from => :converting, :to => :error
  end
  
	def rename_file
		true
	end

  # This method is called from the controller and takes care of the converting
  def convert
    self.convert!
    
    if self.content_type == "video/x-flv" || self.content_type == "application/x-flash-video"
      self.converted!    
    else
  		#spawn a new thread to handle conversion
  		spawn do

  	    success = system(convert_command)
  	    logger.info 'Converting File: ' + success.to_s
  	    if success && $?.exitstatus == 0
  	      self.converted!
  	    else
  	      self.failure!
  	    end
  		end #spawn thread
    end #if else
  end

  def save_thumbnail
	    logger.info "Saving thumbnail of Video..."
	    t = Thumbnail.create!(self.temp_path)
	    self.thumbnail = t
	    t
  end

  def url=(value)
    #file = UrlUpload.new(value)
    #self.uploaded_data = file
  end
  
  protected
  
  def convert_command
		
		#construct new file extension
    flv =  "." + id.to_s + ".flv"

		#build the command to execute ffmpeg
    command = <<-end_command
     ffmpeg -i #{ RAILS_ROOT + '/public' + public_filename } -ar 22050 -s 720x480 -f flv -y #{ RAILS_ROOT + '/public' + public_filename + flv }
      
    end_command
    
    logger.info "Converting video...command: " + command
    command
  end

  # This updates the stored filename with the new flash video file
  def set_new_filename
    update_attribute(:filename, "#{filename}.#{id}.flv") unless self.filename[-3..-1] == "flv"
    update_attribute(:content_type, "application/x-flash-video")
  end


end
