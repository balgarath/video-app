class VideoRepliesController < ApplicationController
  before_filter :require_user, :only => [:create, :delete]
	def create
		@reply = VideoReply.new(params[:video_reply])
		@reply.user = @current_user
		if @reply.save

      flash[:notice] = 'Reply Submitted Successfully'
      redirect_to @reply.video
    else
      render @reply.video
			
		end
		
	end

	def delete
    @reply = VideoReply.find(params[:id])
    @video = @reply.video
    @reply.destroy
    redirect_to	@video
	end
	
end
