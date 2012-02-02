require_relative '../lib/piece'
require_relative '../lib/grid'
require 'test/unit'

#Trida pro testovani ulohy Pentomino Solver
class TestPentomino < Test::Unit::TestCase
  #Metoda, ktera se vola pred kazdym testem. Vytvari instanci tridy Grid a nekolik instanci tridy Piece, s nimiz se pak v kazdem testu pracuje.
  def setup
    @grid = Pentomino::Grid.new(5, 5, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11])
    @piece_l = Pentomino::Piece.new(2, 5)
    @piece_p = Pentomino::Piece.new(4, 2)
    @piece_v = Pentomino::Piece.new(7, 3)
    @piece_x = Pentomino::Piece.new(9, 0)
  end
  
  #Test vytvareni jednotlivych kostek
  def test_piece
    assert_equal([[0, 0], [1, 0], [2, 0], [3, 0], [3, 1]], @piece_l.square_array)
    assert_equal([[1, 0], [0, 1], [1, 1], [0, 2], [1, 2]], @piece_p.square_array)
    assert_equal([[0, 0], [1, 0], [2, 0], [0, 1], [0, 2]], @piece_v.square_array)
    assert_equal([[1, 0], [0, 1], [1, 1], [2, 1], [1, 2]], @piece_x.square_array)
  end
  
  #Test metody insert tridy Grid
  def test_insert
    @grid.insert(2, 1, @piece_p)
    grid_expected = [['.', '.', '.', '.', '.'], ['.', '.', '.', '0', '.'], ['.', '.', '0', '0', '.'], ['.', '.', '0', '0', '.'], ['.', '.', '.', '.', '.']]
    assert_equal(grid_expected, @grid.grid)
  end
  
  #Test metody remove tridy Grid
  def test_remove
    @grid.insert(2, 1, @piece_p)
    @grid.insert(1, 0, @piece_l)
    @grid.remove(2, 1, @piece_p)
    grid_expected = [['.', '1', '1', '1', '1'], ['.', '.', '.', '.', '1'], ['.', '.', '.', '.', '.'], ['.', '.', '.', '.', '.'], ['.', '.', '.', '.', '.']]
    assert_equal(grid_expected, @grid.grid)
    @grid.remove(1, 0, @piece_l)
    grid_expected = [['.', '.', '.', '.', '.'], ['.', '.', '.', '.', '.'], ['.', '.', '.', '.', '.'], ['.', '.', '.', '.', '.'], ['.', '.', '.', '.', '.']]
    assert_equal(grid_expected, @grid.grid)
  end
  
  #Test metody check_space tridy Grid
  def test_check_space
    @grid.insert(2, 1, @piece_p)
    assert_equal(true, @grid.check_space(1, 0, @piece_l.square_array))
    assert_equal(false, @grid.check_space(0, 1, @piece_l.square_array))
    assert_equal(true, @grid.check_space(0, 1, @piece_v.square_array))
  end
  
  #Test metody get_neighbours tridy Grid
  def test_get_neighbours
    @grid.insert(2, 2, @piece_x)
    assert_equal(true, @grid.get_neighbours(4, 4))
    assert_equal(false, @grid.get_neighbours(2, 2))
  end
  
  #Test metody check_grid tridy Grid
  def test_check_grid
    @grid.insert(0, 0, @piece_x)
    assert_equal(-1, @grid.check_grid)
    @grid.remove(0, 0, @piece_x)
    @grid.insert(1, 0, @piece_l)
    @grid.insert(1, 2, @piece_l)
    assert_equal(1, @grid.check_grid)
    piece_l2 = Pentomino::Piece.new(2, 7)
    @grid.insert(0, 0, piece_l2)
    @grid.insert(0, 2, piece_l2)
    piece_i = Pentomino::Piece.new(1, 1)
    @grid.insert(0, 4, piece_i)
    assert_equal(0, @grid.check_grid)
  end
  
  #Testovaci metoda spoustena z metody test_complex. Slouzi ke spusteni komplexniho reseni ulohy Pentomino. 
  #Vraci pocet nalezenych reseni
  def grid_resolve(width, height, types)
    grid = Pentomino::Grid.new(width, height, types)
    types.each { |type| 
      Pentomino::Piece::ORIENTATIONS[type].times { |orientation|
        grid.put_piece(0, 0, type, orientation) 
      }
    }
    grid.solutions
  end
  
  #Komplexni test ulohy Pentomino
  def test_complex
    assert_equal(4, grid_resolve(5, 4, [2]))
    assert_equal(0, grid_resolve(5, 3, [9]))
    assert_equal(1, grid_resolve(1, 10, [1]))
    assert_equal(16, grid_resolve(4, 5, [0, 3, 6, 7, 10, 11]))
  end
  
end