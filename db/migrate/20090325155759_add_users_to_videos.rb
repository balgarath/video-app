class AddUsersToVideos < ActiveRecord::Migration
  def self.up
  	add_column :videos, :user_id, :integer
  end

  def self.down
  	remove_column :videos, :user_id
  end
end

