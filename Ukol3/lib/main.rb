# Pentomino

require_relative 'grid'
require_relative 'piece'

#Trida pro spousteni cele ulohy. Ma na starost nacteni zadani od uzivatele a spusteni algoritmu pro vypocet.
class Program
  #Konstruktor, ktery cte zadani ulohy z uzivatelskeho vstupu a podle neho nastavuje zakladni promenne
  def initialize
    puts "Zadejte delku plochy:"
    @width = gets.to_i
    puts "Zadejte sirku plochy:"
    @height = gets.to_i
    puts "Zadejte ktere typy kostek se maji pouzivat - libovolny vyber pismen FILNPTUVWXYZ (napr. IXZ pro kostky typu I, X a Z):"
    @types = parse_types(gets)
    puts ""
  end
  
  #Metoda pro ziskani typu pouzivanych kostek z uzivatelskeho vstupu
  #* string - uzivatelsky retezec, ktery je testovan na pritomnost znaku F, I, L, N, P, T, U, V, W, X, Y, Z, ktere oznacuji typy kostek, ktere se maji pouzit
  #Vraci pole s typy zvolenych kostek
  def parse_types(string)
    types = []
    letters = ['F', 'I', 'L', 'N', 'P', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']
    letters.each_with_index { |letter,index| 
      if string.upcase.include?(letter)
        types << index
      end
    }
    types
  end
  
  #Metoda pro spusteni vypocetniho algoritmu. Pokud zadani splnuje zakladni podminky, vytvori hraci plochu a postupne zacne zkouset umistovat kostky kazdeho typu v kazde orientaci na prvni pole hraci plochy.
  def start
    area = @width*@height
    if area % 5 != 0
      puts "Zadana plocha obsahuje celkem #{area} poli, takze ji nelze pokryt zadnym poctem kostek velikosti 5."
    elsif @types.empty?
      puts "Nevybrali jste zadne typy kostek, takze plochu nelze pokryt."
    else
      grid = Pentomino::Grid.new(@width, @height, @types)
      @types.each { |type| 
        Pentomino::Piece::ORIENTATIONS[type].times { |orientation|
          grid.put_piece(0, 0, type, orientation) 
        }
      }
      puts "Celkem #{grid.solutions} reseni."
    end
  end
end

program = Program.new
program.start
