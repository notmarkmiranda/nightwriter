require './lib/writer'

if !File.exists?(ARGV[0])
  puts "#{ARGV[0]} does not exist"
  exit
end

raw_text = File.read(ARGV[0]).strip

writer = Writer.new()
converted_text = writer.convert(raw_text)

File.write(ARGV[1], converted_text.join("\n"))

puts "Created '#{ARGV[1]}' containing #{raw_text.length} characters."
