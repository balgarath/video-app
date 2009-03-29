class VideoReply < ActiveRecord::Base
  belongs_to :user
  belongs_to :parent, :class_name => "VideoReply"
  belongs_to :video
end
