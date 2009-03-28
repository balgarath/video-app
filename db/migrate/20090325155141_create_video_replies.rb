class CreateVideoReplies < ActiveRecord::Migration
  def self.up
    create_table :video_replies do |t|
      t.references :user
      t.text :body
      t.references :parent
      t.references :video

      t.timestamps
    end
  end

  def self.down
    drop_table :video_replies
  end
end
