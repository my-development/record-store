require_relative 'model'

if ARGV.empty?
  puts "USAGE: ruby new_format.rb <new_format_name>"
  exit
end

if ARGV.size > 1
  puts "USAGE: ruby new_format.rb  accept only one argument"
  exit
end

begin
	name = ARGV[0].to_s.upcase
	new_format = Format.new(:name => name)
	new_format.save!
	puts "#{name} add into format table."
rescue => e
	puts "Error on insert #{name}: #{e.message}"
end


