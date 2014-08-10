require_relative 'model'

def find_count_each_format(record)
   format_count = {}
   record.inventories.each do |i|
    	  format_count[i.format.name.downcase.to_sym] = {:quantity => i.quantity.to_s, :id => i.id.to_s }
	end
	return format_count
end

if ARGV.empty?
  puts "USAGE: ruby search_inventory.rb <field name> <value>"
  exit
end

if ARGV.size != 2
  puts "USAGE: ruby load_inventory.rb  accept two arguments"
  exit
end

search_field = %w( artist album release_year ) 

field_name = ARGV[0].downcase
search_string = ARGV[1].downcase

unless search_field.include?(field_name)
  puts "Invlide field name. The field name are: #{search_field.inspect}"
  exit
end

case field_name
 when "artist"
	search_result = Album.find(:all, :conditions => ["artist like ?", "%#{search_string}%"] , :order => "artist, release_year DESC")
 when "album"
	search_result = Album.find(:all, :conditions => ["title like ?", "%#{search_string}%" ], :order => "title, release_year DESC")
 when "release_year"
    search_result = Album.find(:all, :conditions => ["release_year = ?", search_string.to_i ], :order => "artist, title")
 else
  puts "Invlide field name. The field name are: #{search_field.inspect}"
  exit 
end

if search_result.empty?
  puts 'No record found.'
  exit
end

search_result.each do |r|
  puts "Artist: #{r.artist}"
  puts "Album: #{r.title}"
  puts "Released: #{r.release_year}"
  
  format_count = find_count_each_format(r)  
  puts "CD(#{format_count[:cd][:quantity]}): #{format_count[:cd][:id]}" if format_count.has_key?(:cd)
  puts "Tape(#{format_count[:tape][:quantity]}): #{format_count[:tape][:id]}"  if format_count.has_key?(:tape)
  puts "Vinyl(#{format_count[:vinyl][:quantity]}): #{format_count[:vinyl][:id]}" if format_count.has_key?(:vinyl)
  puts "\n"
end
