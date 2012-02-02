require_relative '../lib/testcase'
require_relative '../lib/segment'
require 'test/unit'

#Trida pro komplexni testovani ulohy Minimal Coverage
class ComplexTestMinimalCoverage < Test::Unit::TestCase
  #Test pokryvani vzdalenosti useckami (#1).
  # Zadani:
  # 1
  # 
  # 1
  # -1 0
  # -5 -3
  # 2 5
  # 0 0
  def test_simple1
    test_case = Coverage::TestCase.new(1)
    test_case.segments << Coverage::Segment.new(-1, 0)
    test_case.segments << Coverage::Segment.new(-5, -3)
    test_case.segments << Coverage::Segment.new(2, 5)
    assert_equal([], test_case.resolve)
  end
  
  #Test pokryvani vzdalenosti useckami (#2).
  # Zadani:
  # 1
  # 
  # 1
  # -1 0
  # 0 1
  # 0 0
  def test_simple2
    test_case = Coverage::TestCase.new(1)
    test_case.segments << Coverage::Segment.new(-1, 0)
    test_case.segments << Coverage::Segment.new(0, 1)   
    assert_equal([test_case.segments[1]], test_case.resolve)
  end

  #Test pokryvani vzdalenosti useckami (#3).
  # Zadani:
  # 1
  # 
  # 10
  # -2 5
  # -1 6
  # -1 3
  # 0 4
  # 1 5
  # 2 6
  # 3 7
  # 7 8
  # 8 10
  # 8 9
  # 0 0
  def test_simple3
    test_case = Coverage::TestCase.new(10)
    test_case.segments << Coverage::Segment.new(-2, 5)
    test_case.segments << Coverage::Segment.new(-1, 6)
    test_case.segments << Coverage::Segment.new(-1, 3)
    test_case.segments << Coverage::Segment.new(0, 4)
    test_case.segments << Coverage::Segment.new(1, 5)
    test_case.segments << Coverage::Segment.new(2, 6)
    test_case.segments << Coverage::Segment.new(3, 7)
    test_case.segments << Coverage::Segment.new(7, 8)
    test_case.segments << Coverage::Segment.new(8, 10)
    test_case.segments << Coverage::Segment.new(8, 9)
    assert_equal([test_case.segments[1], test_case.segments[6], test_case.segments[7], test_case.segments[8]], test_case.resolve)
  end
  
  #Test pokryvani vzdalenosti useckami (#4).
  # Zadani:
  # 1
  # 
  # 10
  # -2 5
  # -1 6
  # -1 3
  # 0 4
  # 1 5
  # 2 6
  # 3 7
  # 8 10
  # 8 9
  # 0 0
  def test_simple4
    test_case = Coverage::TestCase.new(10)
    test_case.segments << Coverage::Segment.new(-2, 5)
    test_case.segments << Coverage::Segment.new(-1, 6)
    test_case.segments << Coverage::Segment.new(-1, 3)
    test_case.segments << Coverage::Segment.new(0, 4)
    test_case.segments << Coverage::Segment.new(1, 5)
    test_case.segments << Coverage::Segment.new(2, 6)
    test_case.segments << Coverage::Segment.new(3, 7)
    test_case.segments << Coverage::Segment.new(8, 10)
    test_case.segments << Coverage::Segment.new(8, 9)
    assert_equal([], test_case.resolve)
  end
  
  #Test pokryvani vzdalenosti useckami (#5).
  # Zadani:
  # 1
  # 
  # 10
  # 2 5
  # 5 3
  # 2 3
  # 2 5
  # 0 0
  def test_simple5
    test_case = Coverage::TestCase.new(10)
    test_case.segments << Coverage::Segment.new(2, 5)
    test_case.segments << Coverage::Segment.new(5, 3)
    test_case.segments << Coverage::Segment.new(2, 3)
    test_case.segments << Coverage::Segment.new(2, 5)
    assert_equal([], test_case.resolve)
  end
  
  #Test pokryvani vzdalenosti useckami (#6).
  # Zadani:
  # 1
  # 
  # 10
  # 0 10
  # 0 10
  # 0 0
  def test_simple6
    test_case = Coverage::TestCase.new(10)
    test_case.segments << Coverage::Segment.new(0, 10)
    test_case.segments << Coverage::Segment.new(0, 10)
    assert_equal([test_case.segments[0]], test_case.resolve)
  end
    
  #Test pokryvani vzdalenosti useckami (#7).
  # Zadani:
  # 1
  # 
  # 6
  # 0 2
  # 2 4
  # 4 6
  # 6 8
  # 0 0
  def test_simple7
    test_case = Coverage::TestCase.new(6)
    test_case.segments << Coverage::Segment.new(0, 2)
    test_case.segments << Coverage::Segment.new(2, 4)
    test_case.segments << Coverage::Segment.new(4, 6)
    test_case.segments << Coverage::Segment.new(6, 8)
    assert_equal([test_case.segments[0], test_case.segments[1], test_case.segments[2]], test_case.resolve)
  end
end
