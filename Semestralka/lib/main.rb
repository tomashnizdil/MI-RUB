# HTML Parser

require_relative 'parser'
require_relative 'printer'

if ARGV.length == 0 || ARGV.length > 2
  puts "Usage: main.rb input_file.html <output_file.html>"
  exit
else
  if !FileTest.exist?(ARGV[0])
    puts "Zadany soubor '#{ARGV[0]}' neexistuje!"
    exit
  end
  root = HTML_Parser::Parser.new(ARGV[0], "dictionary.txt").parse
  if ARGV.length == 2
    file = File.open(ARGV[1], "w")
    puts "Document structure is in file '#{ARGV[1]}'."
    HTML_Parser::Printer.new(file).print_tree(root)
    file.close
  else
    puts "Document structure:"
    HTML_Parser::Printer.new.print_tree(root)
  end
end