require_relative 'model'


if ARGV.empty?
  puts "USAGE: ruby purchase.rb <inventory id>"
  exit
end

if ARGV.size > 1
  puts "USAGE: ruby purchase.rb  accept only one argument"
  exit
end

uid = ARGV[0]

unless uid =~ /\d/
  puts "the item id (#{uid}) is not a number."
  exit
end

begin 
 item = Inventory.find(uid.to_i)
 
 title = item.album.title
 format = item.format.name

 if item.quantity > 0
	item.quantity -= 1
	item.save!
	puts "Removed 1 #{format} of #{title} from the inventory"
 else
	puts "There is not #{format} of #{title} in the inventory."
 end
rescue => e
    puts "#{e.message}"
end
