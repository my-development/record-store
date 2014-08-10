require_relative 'database_config'

class Schema < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|
     	t.string 	:title
		t.string 	:artist
     	t.integer 	:release_year
    end
	add_index :albums, :title
    add_index :albums, :artist

    create_table :formats do |t|
		t.string	:name
    end
	add_index :formats, :name
	
    create_table :inventories do |t|
		t.integer	:album_id
		t.integer	:format_id
		t.integer	:quantity, :default => 0
    end
	add_index :inventories, :album_id
	add_index :inventories, :format_id
  end
  
  def self.down
	drop_table :albums
	drop_table :formats
	drop_table :inventories
  end
end

Schema.down  # comment out for first time execute this file.
Schema.up

