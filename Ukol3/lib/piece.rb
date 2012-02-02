module Pentomino
  #Trida reprezentujici kostku pentomina
  class Piece
    #Pole souradnic, ktere kostka pokryva
    attr_reader :square_array
    #Konstanta udavajici pocet ruznych kostek pentomina
    TYPES = 12
    #Konstantni pole udavajici pocet ruznych orientaci (otoceni nebo prevraceni) pro kazdou kostku pentomina
    ORIENTATIONS = [8, 2, 8, 8, 8, 4, 4, 4, 4, 1, 8, 4]
  
    #Konstruktor vytvarejici kostku podle zadanych parametru
    #* type - typ kostky
    #* orientation - orientace kostky
    def initialize(type, orientation)
      case type
      when 0 then create_f(orientation)
      when 1 then create_i(orientation)
      when 2 then create_l(orientation)
      when 3 then create_n(orientation)
      when 4 then create_p(orientation)
      when 5 then create_t(orientation)
      when 6 then create_u(orientation)
      when 7 then create_v(orientation)
      when 8 then create_w(orientation)
      when 9 then create_x
      when 10 then create_y(orientation)
      when 11 then create_z(orientation)
      end
    end
  
    # Metoda pro vytvoreni kostky typu F
    #  00
    # 00
    #  0
    def create_f(orientation)
      case orientation
      when 0 then @square_array = [[1, 0], [2, 0], [0, 1], [1, 1], [1, 2]]
      when 1 then @square_array = [[1, 0], [0, 1], [1, 1], [2, 1], [2, 2]]
      when 2 then @square_array = [[1, 0], [1, 1], [2, 1], [0, 2], [1, 2]]
      when 3 then @square_array = [[0, 0], [0, 1], [1, 1], [2, 1], [1, 2]]
      when 4 then @square_array = [[0, 0], [1, 0], [1, 1], [2, 1], [1, 2]]
      when 5 then @square_array = [[1, 0], [0, 1], [1, 1], [2, 1], [0, 2]]
      when 6 then @square_array = [[1, 0], [0, 1], [1, 1], [1, 2], [2, 2]]
      when 7 then @square_array = [[2, 0], [0, 1], [1, 1], [2, 1], [1, 2]]
      end
    end
  
    # Metoda pro vytvoreni kostky typu I
    # 0
    # 0
    # 0
    # 0
    # 0
    def create_i(orientation)
      case orientation
      when 0 then @square_array = [[0, 0], [0, 1], [0, 2], [0, 3], [0, 4]]
      when 1 then @square_array = [[0, 0], [1, 0], [2, 0], [3, 0], [4, 0]]
      end
    end
  
    #Metoda pro vytvoreni kostky typu L
    # 0
    # 0
    # 0
    # 00
    def create_l(orientation)
      case orientation
      when 0 then @square_array = [[0, 0], [0, 1], [0, 2], [0, 3], [1, 3]]
      when 1 then @square_array = [[0, 1], [1, 1], [2, 1], [3, 1], [3, 0]]
      when 2 then @square_array = [[0, 0], [1, 0], [1, 1], [1, 2], [1, 3]]
      when 3 then @square_array = [[0, 0], [0, 1], [1, 0], [2, 0], [3, 0]]
      when 4 then @square_array = [[1, 0], [1, 1], [1, 2], [1, 3], [0, 3]]
      when 5 then @square_array = [[0, 0], [1, 0], [2, 0], [3, 0], [3, 1]]
      when 6 then @square_array = [[0, 0], [1, 0], [0, 1], [0, 2], [0, 3]]
      when 7 then @square_array = [[0, 0], [0, 1], [1, 1], [2, 1], [3, 1]]
      end
    end
  
    #Metoda pro vytvoreni kostky typu N
    #  0
    #  0
    # 00
    # 0
    def create_n(orientation)
      case orientation
      when 0 then @square_array = [[1, 0], [0, 1], [1, 1], [0, 2], [0, 3]]
      when 1 then @square_array = [[0, 0], [1, 0], [1, 1], [2, 1], [3, 1]]
      when 2 then @square_array = [[1, 0], [1, 1], [0, 2], [1, 2], [0, 3]]
      when 3 then @square_array = [[0, 0], [1, 0], [2, 0], [2, 1], [3, 1]]
      when 4 then @square_array = [[0, 0], [0, 1], [1, 1], [1, 2], [1, 3]]
      when 5 then @square_array = [[1, 0], [2, 0], [3, 0], [0, 1], [1, 1]]
      when 6 then @square_array = [[0, 0], [0, 1], [0, 2], [1, 2], [1, 3]]
      when 7 then @square_array = [[2, 0], [3, 0], [0, 1], [1, 1], [2, 1]]
      end
    end
  
    #Metoda pro vytvoreni kostky typu P
    # 00
    # 00
    # 0
    def create_p(orientation)
      case orientation
      when 0 then @square_array = [[0, 0], [1, 0], [0, 1], [1, 1], [0, 2]]
      when 1 then @square_array = [[0, 0], [1, 0], [0, 1], [1, 1], [2, 1]]
      when 2 then @square_array = [[1, 0], [0, 1], [1, 1], [0, 2], [1, 2]]
      when 3 then @square_array = [[0, 0], [1, 0], [2, 0], [1, 1], [2, 1]]
      when 4 then @square_array = [[0, 0], [1, 0], [0, 1], [1, 1], [1, 2]]
      when 5 then @square_array = [[0, 0], [1, 0], [0, 1], [1, 1], [2, 0]]
      when 6 then @square_array = [[0, 0], [0, 1], [1, 1], [0, 2], [1, 2]]
      when 7 then @square_array = [[0, 1], [1, 0], [2, 0], [1, 1], [2, 1]]
      end
    end
  
    #Metoda pro vytvoreni kostky typu T
    # 000
    #  0
    #  0
    def create_t(orientation)
      case orientation
      when 0 then @square_array = [[0, 0], [1, 0], [2, 0], [1, 1], [1, 2]]
      when 1 then @square_array = [[0, 0], [0, 1], [1, 1], [2, 1], [0, 2]]
      when 2 then @square_array = [[1, 0], [1, 1], [0, 2], [1, 2], [2, 2]]
      when 3 then @square_array = [[2, 0], [0, 1], [1, 1], [2, 1], [2, 2]]
      end
    end
  
    #Metoda pro vytvoreni kostky typu U
    # 0 0
    # 000
    def create_u(orientation)
      case orientation
      when 0 then @square_array = [[0, 0], [2, 0], [0, 1], [1, 1], [2, 1]]
      when 1 then @square_array = [[0, 0], [1, 0], [1, 1], [0, 2], [1, 2]]
      when 2 then @square_array = [[0, 0], [1, 0], [2, 0], [0, 1], [2, 1]]
      when 3 then @square_array = [[0, 0], [1, 0], [0, 1], [0, 2], [1, 2]]
      end
    end
  
    #Metoda pro vytvoreni kostky typu V
    # 0
    # 0
    # 000
    def create_v(orientation)
      case orientation
      when 0 then @square_array = [[0, 0], [0, 1], [0, 2], [1, 2], [2, 2]]
      when 1 then @square_array = [[2, 0], [2, 1], [0, 2], [1, 2], [2, 2]]
      when 2 then @square_array = [[0, 0], [1, 0], [2, 0], [2, 1], [2, 2]]
      when 3 then @square_array = [[0, 0], [1, 0], [2, 0], [0, 1], [0, 2]]
      end
    end
  
    #Metoda pro vytvoreni kostky typu W
    # 0
    # 00
    #  00
    def create_w(orientation)
      case orientation
      when 0 then @square_array = [[0, 0], [0, 1], [1, 1], [1, 2], [2, 2]]
      when 1 then @square_array = [[2, 0], [1, 1], [2, 1], [0, 2], [1, 2]]
      when 2 then @square_array = [[0, 0], [1, 0], [1, 1], [2, 1], [2, 0]]
      when 3 then @square_array = [[1, 0], [2, 0], [0, 1], [1, 1], [0, 2]]
      end
    end
  
    #Metoda pro vytvoreni kostky typu X
    #  0
    # 000
    #  0
    def create_x
      @square_array = [[1, 0], [0, 1], [1, 1], [2, 1], [1, 2]]
    end
  
    #Metoda pro vytvoreni kostky typu Y
    #  0
    # 00
    #  0
    #  0
    def create_y(orientation)
      case orientation
      when 0 then @square_array = [[1, 0], [0, 1], [1, 1], [1, 2], [1, 3]]
      when 1 then @square_array = [[0, 0], [1, 0], [2, 0], [3, 0], [1, 1]]
      when 2 then @square_array = [[0, 0], [0, 1], [0, 2], [1, 2], [0, 3]]
      when 3 then @square_array = [[2, 0], [0, 1], [1, 1], [2, 1], [3, 1]]
      when 4 then @square_array = [[0, 0], [0, 1], [1, 1], [0, 2], [0, 3]]
      when 5 then @square_array = [[1, 0], [0, 1], [1, 1], [2, 1], [3, 1]]
      when 6 then @square_array = [[1, 0], [1, 1], [0, 2], [1, 2], [1, 3]]
      when 7 then @square_array = [[0, 0], [1, 0], [2, 0], [3, 0], [2, 1]]
      end
    end
  
    #Metoda pro vytvoreni kostky typu Z
    # 00
    #  0
    #  00
    def create_z(orientation)
      case orientation
      when 0 then @square_array = [[0, 0], [1, 0], [1, 1], [1, 2], [2, 2]]
      when 1 then @square_array = [[2, 0], [0, 1], [1, 1], [2, 1], [0, 2]]
      when 2 then @square_array = [[1, 0], [2, 0], [1, 1], [0, 2], [1, 2]]
      when 3 then @square_array = [[0, 0], [0, 1], [1, 1], [2, 1], [2, 2]]
      end
    end
  end
end
