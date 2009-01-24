class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.string :content_type
      t.integer :size
      t.string :filename
      t.string :title
      t.string :description
      t.string :state
      t.timestamps
    end
  end

  def self.down
    drop_table :videos
  end
end
