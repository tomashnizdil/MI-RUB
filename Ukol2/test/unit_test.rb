require_relative '../lib/rectangle'
require 'test/unit'

#Trida pro testovani ulohy Rectangles
class TestRectangle < Test::Unit::TestCase
  #Metoda setup, ktera slouzi jako prolog pred kazdym jednotlivym testem
  def setup
    @ctverec1 = Rectangles::Ctverec.new(1)
    @ctverec2 = Rectangles::Ctverec.new(2)
  end
  
  #Test nacitani hodnot do jednotlivych atributu tridy Ctverec
  def test_nacitani_hodnot
    hrana, x, y = 1.0, 2.0, 3.0
    @ctverec1.nacti_hodnoty([hrana, x, y])
    assert_equal(hrana, @ctverec1.hrana )
    assert_equal(y-hrana/2, @ctverec1.dolni )
    assert_equal(y+hrana/2, @ctverec1.horni )
    assert_equal(x-hrana/2, @ctverec1.leva )
    assert_equal(x+hrana/2, @ctverec1.prava )
    assert_equal(hrana*hrana, @ctverec1.vypocti_obsah )
  end
  
  #Test kompletnich vypoctu ulohy
  def test_vypoctu
    @ctverec1.nacti_hodnoty([4, 0, 0])
    @ctverec2.nacti_hodnoty([2, 2, 2])
    assert_equal("Obsah sjednoceni dvou ctvercu je 19.", Rectangles.vypocti_sjednoceni(@ctverec1, @ctverec2))
    @ctverec1.nacti_hodnoty([4.0, 0.000, 0.000e-3])
    @ctverec2.nacti_hodnoty([2.0e+0, -2, -2e0])
    assert_equal("Obsah sjednoceni dvou ctvercu je 19.", Rectangles.vypocti_sjednoceni(@ctverec1, @ctverec2))
    @ctverec1.nacti_hodnoty([5.23, -10e20, 3e-2])
    @ctverec2.nacti_hodnoty([4.345643225, +3e100, -1])
    assert_equal("Obsah sjednoceni dvou ctvercu je 49.99533665148841.", Rectangles.vypocti_sjednoceni(@ctverec1, @ctverec2))
    @ctverec1.nacti_hodnoty([1, -10, -10])
    @ctverec2.nacti_hodnoty([2, 5, 5])
    assert_equal("Ctverce se ani nedotykaji.", Rectangles.vypocti_sjednoceni(@ctverec1, @ctverec2))
  end
end
