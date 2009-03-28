class TagsController < ApplicationController
	def index
		@tags = Tag.find :all
	end
	
	def show
		@tag = Tag.find_by_name(params[:id])
		@videos = Video.paginate_by_id(Video.find_tagged_with(@tag), :page => params[:page], :per_page => 10)
	end
end
