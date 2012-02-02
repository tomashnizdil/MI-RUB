#Hlavni modul ulohy The Decipher [https://edux.fit.cvut.cz/courses/MI-RUB/homeworks/04/start]
module Decipher
  #Trida Decipher definujici algoritmus pro desifrovani
  class Decipher
    #Konstruktor, ktery obsluhuje otevreni vstupniho souboru se sifrovanym textem a nastaveni pouziti pevneho klice nebo frekvencni analyzy
    #* file - zdrojovy soubor s kodovanym textem
    #* key - true pro pouziti frekvencni analyzy kodovaneho textu, false pro pouziti pevne nastaveneho klice
    def initialize(file, key)
      if !FileTest.exist?(file)
        puts "File '#{file}' does not exist!"
        exit
      end
      @input = File.open(file, "r")
      if key
        @key = frequency_analysis
      else
        @key = '*'.ord - '1'.ord
      end
    end
  
    #Metoda zajistujici dekodovani zdrojoveho souboru pomoci predem nastaveneho klice. Pricte ke kazdemu bytu zdrojoveho souboru zvoleny klic a vrati cely dekodovany text.
    def run
      output = ""
      @input.rewind
      @input.each_byte { |x| 
        x = x + @key
        output << x
      }
      @input.close
      output
    end
  
    #Metoda pro urceni klice pomoci frekvencni analyzy kodovaneho textu. 
    #Vraci klic pro dekodovani textu jako rozdil mezi nejcetnejsim znakem v textu a ' '.
    def frequency_analysis
      letters = {}
      @input.each_byte { |x|
        if !letters[x].kind_of?(Fixnum)
          letters[x] = 0
        end
        letters[x] = letters[x] + 1
      }
      max, index = 0, 0
      letters.each { |item| 
        if item[1] > max
          max = item[1]
          index = item[0]
        end
      }
      ' '.ord - index
    end
  end
end