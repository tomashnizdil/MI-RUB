require_relative 'piece'

#Hlavni modul ulohy Pentomino Solver
module Pentomino
  #Trida reprezentujici hraci plochu
  class Grid
    #Atribut zaznamenavajici pocet nalezenych reseni
    attr_reader :solutions
    #2D pole reprezentujici hraci plochu (atribut pro cteni kvuli testovani)
    attr_reader :grid
  
    #Konstruktor, ktera vytvari hraci plochu, nastavuje typy pouzitych kostek a inicializuje nektere instancni promenne.
    #* width - delka hraci plochy
    #* height - sirka hraci plochy
    #* types - pole s typy pouzivanych kostek
    def initialize(width, height, types)
      @width, @height, @types = width, height, types
      @grid = Array.new(@height) {Array.new(@width, ".")}
      @symbol = 48 # 48.chr => '0'
      @start = false
      @solutions = 0
      @solutions_array = []
    end
  
    #Metoda pro vkladani kostky na danou souradnici. Na urcena mista hraciho pole nakopiruje symbol pro pouzitou kostku.
    #* x - x-ova souradnice pole
    #* y - y-ova souradnice pole
    #* piece - instance tridy Piece, ktera reprezentuje vkladanou kostku
    def insert(x, y, piece)
      piece.square_array.each { |square|
        @grid[y+square[1]][x+square[0]] = @symbol.chr
      }
      @symbol = @symbol+1
    end
  
    #Metoda pro odebirani kostky z dane souradnice. Z urcenych mist hraciho pole vymaze symbol pro pouzitou kostku.
    #* x - x-ova souradnice pole
    #* y - y-ova souradnice pole
    #* piece - instance tridy Piece, ktera reprezentuje odebiranou kostku
    def remove(x, y, piece)
      piece.square_array.each { |square|
        @grid[y+square[1]][x+square[0]] = '.'
      }
      @symbol = @symbol-1
    end
  
    #Metoda pro preklad reseni do "normalni formy" pro kontrolu duplicitnich reseni.
    #* solution - pole s reprezentaci aktualniho nalezeneho reseni
    #Vraci reseni v "normalni forme".
    def translate(solution)
      translation = {}
      symbol = 48
      solution.each_with_index { |item,i|  
        if translation[item] == nil
          translation[item] = symbol.chr
          symbol = symbol + 1
        end
        solution[i] = translation[item]
      }
      solution
    end
  
    #Metoda porovnavajici jednotliva reseni pro vylouceni duplicity.
    #* actual - pole reprezentujici aktualni nalezene reseni
    #Vraci true, pokud se aktualni reseni shoduje s nekterym jiz drive nalezenym a false, pokud je jine, nez vsechny dosud nalezene.
    def compare(actual)
      @solutions_array.each { |s| 
        if s.eql?(translate(actual))
          return true
        end
      }
      return false
    end
  
    #Metoda kontrolujici, jestli jsou jednotliva pole, kam se ma kostka vlozit, volna.
    #* x - x-ova souradnice pole
    #* y - y-ova souradnice pole
    #* square_array - pole s vyctem souradnic hraci plochy, kam se ma kostka umistit
    #Vraci false, pokud se kostka na dane misto nevejde a true pokud je mozno ji vlozit.
    def check_space(x, y, square_array)   
      square_array.each { |square| 
        if x+square[0] < 0 || x+square[0] >= @width || y+square[1] < 0 || y+square[1] >= @height || @grid[y+square[1]][x+square[0]] != '.'
          return false
        end
      }
      true
    end
  
    #Stezejni metoda pro reseni ulohy. Resi kompletni mechanismus vkladani kostky daneho typu s danou orientaci na urcene souradnice hraci plochy.
    #* x - x-ova souradnice pole
    #* y - y-ova souradnice pole
    #* type - typ vkladane kostky
    #* orientation - orientace vkladane kostky
    def put_piece(x, y, type, orientation)
      piece = Piece.new(type, orientation)
    
      if !check_space(x, y, piece.square_array) 
        return
      end
    
      insert(x, y, piece)

      free_square = check_grid
      if free_square == 0
        actual = []
        @grid.each { |row| 
          row.each { |square| 
            actual << square
          }
        }  
        if !compare(actual)
          @solutions = @solutions + 1
          puts "SOLUTION #{@solutions}"
        
          @solutions_array << translate(actual)
          show
        end
      elsif free_square > 0
        (@width).times { |x| 
          (@height).times { |y| 
            @types.each { |type| 
              Piece::ORIENTATIONS[type].times { |orientation| 
                put_piece(x, y, type, orientation)
              }
            }
          }
        }
      end
    
      remove(x, y, piece)
    end
  
    #Metoda kontrolujici obsazenost sousednich poli nalezeneho pole o souradnicich x a y. 
    #* x - x-ova souradnice pole
    #* y - y-ova souradnice pole
    #Vraci true, pokud volne pole nema okolo sebe zadne jine volne pole (takove pole uz pak nelze zaplnit zadnou kostkou, takze se jedna o slepou vypocetni vetev) a false, pokud pole ma nejakeho nezaplneneho souseda.
    def get_neighbours(x, y)
      neighbours = []
      if x > 0
        neighbours << @grid[y][x-1]
      end
      if x < @width-1
        neighbours << @grid[y][x+1]
      end
      if y > 0
        neighbours << @grid[y-1][x]
      end
      if y < @height-1
        neighbours << @grid[y+1][x]
      end
      neighbours.each { |square| 
        if square == '.'
          return false
        end
      }
      true
    end
  
    #Metoda kontrolujici obsazeni hraci plochy. Signalizuje nalezeni reseni, nebo vynechani volneho mista. Pripadne vynechani nezaplnitelneho mista a tedy slepou vypocetni vetev.
    def check_grid
      covered = 0
      @width.times { |x| 
        @height.times { |y| 
          if @grid[y][x] == '.'
            if get_neighbours(x, y)
              return -1
            end
            covered = 1
          end
        }
      }
      return covered
    end
  
    #Metoda pro vypis hraci plochy
    def show
      @grid.each_with_index { |row, i| 
        row.each_with_index { |cell, j| 
          print cell, " "
        }
        print "\n"
      }
      print "\n"
    end
  end
end