require_relative '../lib/decipher'
require 'test/unit'

#Trida pro testovani ulohy The Decipher
class TestDecipher < Test::Unit::TestCase
  #Test metody frequency_analysis. Metoda ma na zaklade frekvencni analyzy souboru vratit spravny klic.
  def test_simple
    key = ' '.ord - '\''.ord
    decipher = Decipher::Decipher.new("testfile.txt", false)
    assert_equal(key, decipher.frequency_analysis)
    decipher = Decipher::Decipher.new("testfile2.txt", false)
    assert_equal(key, decipher.frequency_analysis)
    decipher = Decipher::Decipher.new("testfile3.txt", false)
    assert_equal(key, decipher.frequency_analysis)
  end
  
  #Komplexni test desifrovani s pevne nastavenym klicem
  def test_static_key
    decipher = Decipher::Decipher.new("testfile.txt", false) # with static key
    assert_equal("*CDC is the trademark of the Control Data Corporation.", decipher.run)
    decipher = Decipher::Decipher.new("testfile2.txt", false) # with static key  
    assert_equal("*IBM is a trademark of the International Business Machine Corporation.", decipher.run)
    decipher = Decipher::Decipher.new("testfile3.txt", false) # with static key
    assert_equal("*DEC is the trademark of the Digital Equipment Corporation.", decipher.run)
  end
  
  #Komplexni test desifrovani s vyuzitim frekvencni analyzy
  def test_frequency_analysis
    decipher = Decipher::Decipher.new("testfile.txt", true) # with frequency analysis
    assert_equal("*CDC is the trademark of the Control Data Corporation.", decipher.run)
    decipher = Decipher::Decipher.new("testfile2.txt", true) # with frequency analysis  
    assert_equal("*IBM is a trademark of the International Business Machine Corporation.", decipher.run)
    decipher = Decipher::Decipher.new("testfile3.txt", true) # with frequency analysis
    assert_equal("*DEC is the trademark of the Digital Equipment Corporation.", decipher.run)
  end
end