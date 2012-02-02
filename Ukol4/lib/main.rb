# Decipher

require_relative 'decipher'

if ARGV.length != 1
  puts "Usage: main.rb encryptedFile"
else
  decipher = Decipher::Decipher.new(ARGV[0], false)
  puts decipher.run
end
