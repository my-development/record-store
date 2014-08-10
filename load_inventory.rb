require_relative 'model'
require 'csv'

def csv_import(data_file, file_type)
  fields_name = {
	 :csv => %w( artist title format release_year ),
   :pipe => %w( quanitity format release_year artist title )
  }

  file_info = fields_name[file_type.to_sym]
  field_size = file_info.size
  
  if data_file.first.size != field_size
	  puts "Import file is invlid columns, and the right size is #{field_size}."
      exit 
  end
  
  
   data_file.each do |row|
	# puts row.inspect
	
	 if row.size != field_size
	    puts row.inspect
	    puts "current record has wrong columns, and the right size is #{field_size}."
		next
	 end
	 album_attributes = {:artist => row[file_info.index('artist')], :title => row[file_info.index('title')], :release_year => row[file_info.index('release_year')]}
	 album = Album.where(album_attributes).first_or_create!
	 format = Format.where({:name => row[file_info.index('format')]}).first_or_create!
	 inventory = Inventory.where({:album_id =>  album.id, :format_id => format.id} ).first_or_create!
	 quantity = file_type == 'pipe' ? row[file_info.index('quanitity')].to_i : 1
	 inventory.quantity += quantity
	 inventory.save!
   end
 
  
end


if ARGV.empty?
  puts "USAGE: ruby load_inventory.rb <inventory file name>"
  exit
end

if ARGV.size > 1
  puts "USAGE: ruby load_inventory.rb  accept only one argument"
  exit
end

import_file_name = ARGV[0].to_s

unless File.exist?(import_file_name)
  puts "#{import_file_name} does not exist."
  exit
end 

file_type = File.extname(import_file_name).sub('.', '').downcase

begin
 case file_type
  when 'csv'
	data_file = CSV.read(import_file_name, { :headers => false, :skip_blanks => true })
  when 'pipe'
    data_file = CSV.read(import_file_name, { :headers => false, :col_sep => " | ", :skip_blanks => true })
  else
	puts "#{import_file_name} has wrong file extenion, only acceptes csv or pipe file."
    exit
 end

 if data_file.empty?
   puts "#{import_file_name} is empty."
   exit
 end

 csv_import(data_file, file_type)
 
rescue CSV::MalformedCSVError
   puts 'Invalid csv file.'
   exit
rescue => e
   puts e.message
   exit
end








