require_relative 'segment'

#Modul seskupujici casti ulohy Minimal Coverage [https://edux.fit.cvut.cz/courses/MI-RUB/homeworks/05/start]
module Coverage
  #Trida pro reprezentaci konkretniho ukolu pokryti dane vzdalenosti mnozinou usecek
  class TestCase
    #Pole instanci tridy Segment, pomoci nichz se ma usecka pokryt
    attr_accessor :segments
    
    #Konstruktor, ktery nastavuje delku pokryvane cary a vytvari prazdne pole segmentu, pomoci nichz se bude pokryvat
    #* lineLength - delka pokryvane cary
    def initialize(lineLength)
      @lineLength = lineLength
      @segments = []
    end
  
    #Metoda, ktera cte cast zadani ze standardniho vstupu a vytvari jednotlive segmenty k pokryti pozadovane vzdalenosti.
    def get_segments
      while 1 > 0
        ends = gets.split(' ')
        li, ri = ends[0].to_i, ends[1].to_i
        break if (li == 0 and ri == 0)
        if li > ri
          li, ri = ends[1].to_i, ends[0].to_i
        end
        @segments << Segment.new(li, ri)
      end
    end
  
    #Metoda hledajici nejvhodnejsi usecku k pokryti
    #* start - zacatek pokryvane oblasti
    #Vraci hledany segment, nebo -1, pokud se zadny vhodny kandidat nenasel.
    def find_segment(start)
      segment, max = -1, start
      @segments.each_with_index { |s, i| 
        if s.li <= start && s.ri > start && s.ri > max
          segment = i
          max = s.ri
        end
      }
      segment
    end
  
    #Metoda hledajici reseni daneho TestCase. Ze zadanych usecek vybira nejmensi podmnozinu, ktera pokryva urcenou vzdalenost. 
    #Vraci pole segmentu, resici danou ulohu.
    def resolve
      distance_covered = 0
      segments_used = []
      while distance_covered < @lineLength
        segment = find_segment(distance_covered)
        if segment < 0
          puts 0
          print "\n"
          return []
        end
        segments_used << @segments[segment]
        distance_covered = @segments[segment].ri
      end
      puts segments_used.length
      segments_used.each { |segment| 
        segment.print_coordinates
      }
      print "\n"
      segments_used
    end
  end
end