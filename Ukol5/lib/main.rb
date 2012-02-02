# Minimal coverage

require_relative 'testcase'

#Trida zajistujici spousteni cele ulohy
class Program
  #Konstruktor, ktery cte zadani ulohy ze standardniho vstupu a spousti jednotlive TestCases
  def initialize
    puts "Please insert input data:"
    @testCasesCount = gets.to_i  
    @testCases = Array.new(@testCasesCount)
    
    for i in 0..@testCasesCount-1
      gets # blank line
      @testCases[i] = Coverage::TestCase.new(gets.to_i) # line length
      @testCases[i].get_segments
    end
    puts "\nOutput:"
    for i in 0..@testCasesCount-1
      @testCases[i].resolve
    end
  end
end

Program.new
