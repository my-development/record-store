require_relative 'database_config'

class Album < ActiveRecord::Base
	has_many :inventories, :dependent => :delete_all
					
	
    has_many :formats, :through => :inventories
	
	validates_presence_of :title, :artist, :release_year
	validates_uniqueness_of :title, :scope => :artist, :case_sensitive => false
end

class Format < ActiveRecord::Base
	has_many :inventories, :dependent => :delete_all
	has_many :albums, :through => :inventories

	validates_presence_of :name
	validates_uniqueness_of :name, :case_sensitive => false
end

class Inventory < ActiveRecord::Base
	belongs_to :album
	belongs_to :format
	
	validates_presence_of :album_id, :format_id
	validates_uniqueness_of :album_id, :scope => :format_id
end




