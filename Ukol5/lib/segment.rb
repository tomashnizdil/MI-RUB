module Coverage
  #Trida pro reprezentaci casti usecky, kterou lze pokryvat zadanou vzdalenost
  class Segment
    #Atribut pro levy okraj usecky
    attr_reader :li
    #Atribut pro pravy okraj usecky
    attr_reader :ri
    #Konstruktor, ktery nastavuje levy a pravy okraj usecky
    #* li - levy okraj
    #* ri - pravy okraj
    def initialize(li, ri)
      @li = li
      @ri = ri
    end
  
    #Metoda pro vypis souradnic usecky
    def print_coordinates
      print @li, " ", @ri, "\n"
    end
  end
end
