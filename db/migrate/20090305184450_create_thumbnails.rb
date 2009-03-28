
class CreateThumbnails < ActiveRecord::Migration
  def self.up
  	
  	#create new table
    create_table :thumbnails do |t|
      t.string :content_type
      t.integer :size
      t.string :filename
      t.timestamps
    end
    
    #add foreign key to video table
    add_column :videos, :thumbnail_id, :integer
    
  end

  def self.down
    drop_table :thumbnails
    remove_column :videos, :thumbnail_id
  end
end
