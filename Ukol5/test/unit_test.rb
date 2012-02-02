require_relative '../lib/testcase'
require_relative '../lib/segment'
require 'test/unit'

#Trida pro unit testovani ulohy Minimal Coverage
class UnitTestMinimalCoverage < Test::Unit::TestCase
  #Test konstruktoru tridy Segment. Konstruktor ma spravne nastavovat hodnoty atributu li a ri.
  def test_simple
    segment = Coverage::Segment.new(5, 10)
    assert_equal(5, segment.li)
    assert_equal(10, segment.ri)
  end
  
  #Test metody find_segment tridy TestCase. Metoda ma vratit index segmentu s maximalnim ri, ktery prochazi zadanym bodem, nebo -1, pokud takovy segment neexistuje.
  def test_simple2
    segments = [Coverage::Segment.new(-2, 3), Coverage::Segment.new(1, 2), Coverage::Segment.new(5, 7)]
    test_case = Coverage::TestCase.new(8)
    test_case.segments = segments
    assert_equal(-1, test_case.find_segment(7))
    assert_equal(0, test_case.find_segment(1))
    assert_equal(2, test_case.find_segment(5))
  end
  
  #Test metody resolve tridy TestCase. Metoda ma vratit nejmensi pole segmentu, ktere pokryvaji danou usecku, nebo prazdne pole, pokud reseni neexistuje.
  def test_simple3
    segments = [Coverage::Segment.new(-2, 3), Coverage::Segment.new(5, 7), Coverage::Segment.new(2, 5)]
    test_case = Coverage::TestCase.new(8)
    test_case.segments = []
    assert_equal([], test_case.resolve)
    test_case.segments = segments
    assert_equal([], test_case.resolve)
    test_case = Coverage::TestCase.new(6)
    test_case.segments = segments
    assert_equal([segments[0], segments[2], segments[1]], test_case.resolve)
    test_case = Coverage::TestCase.new(5)
    test_case.segments = segments
    assert_equal([segments[0], segments[2]], test_case.resolve)
  end
end