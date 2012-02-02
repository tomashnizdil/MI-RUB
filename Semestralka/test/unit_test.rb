require_relative '../lib/dictionary'
require_relative '../lib/dom_nodes'
require_relative '../lib/parser'
require_relative '../lib/printer'
require 'test/unit'

#Trida pro testovani html parseru
class TestUnit < Test::Unit::TestCase 
  
  #Test vytvareni slovniku
  def test_dictionary
    dictionary = HTML_Parser::Dictionary.new("lib/dictionary.txt")
    assert_equal(["head", "body"], dictionary.tags["html"])
    assert_equal(["b", "i", "u", "br", "a", "img", "input", "select", "table", "ul", "ol", "form"], dictionary.tags["p"])
    assert_equal(["caption", "tr", "thead", "tbody", "tfoot"], dictionary.tags["table"])
    assert_equal([], dictionary.tags["title"])
    assert_equal(nil, dictionary.tags["br"])
    
    assert_equal(["version", "lang", "dir"], dictionary.attributes["html"])
    assert_equal(["summary", "width", "align", "border", "cellpadding", "cellspacing", "frame", "rules"], dictionary.attributes["table"])
    assert_equal(["type", "value", "src", "size", "name", "maxlength", "checked", "alt"], dictionary.attributes["input"])
    
    assert_equal([], dictionary.values[["img", "src"]])
    assert_equal(["1", "A", "a", "I", "i"], dictionary.values[["ol", "type"]])
  end
  
  #Test jednotlivych uzlu stromove struktury
  def test_nodes
    root = HTML_Parser::DOM_Nodes::Tag.new("A", true, nil)
    tag1 = HTML_Parser::DOM_Nodes::Tag.new("B", true, root)
    tag2 = HTML_Parser::DOM_Nodes::Tag.new("C", true, root)
    tag3 = HTML_Parser::DOM_Nodes::Tag.new("D", true, tag1)
    assert_equal([tag1, tag2], root.children)
    assert_equal([tag3], tag1.children)
    assert_equal([], tag2.children)
    attribute1 = HTML_Parser::DOM_Nodes::Attribute.new("a1", 5)
    attribute2 = HTML_Parser::DOM_Nodes::Attribute.new("a1", 6)
    attribute3 = HTML_Parser::DOM_Nodes::Attribute.new("a1", 7)
    root.add_attribute(attribute1)
    root.add_attribute(attribute2)
    tag1.add_attribute(attribute3)
    assert_equal([attribute1, attribute2], root.attributes)
    assert_equal([attribute3], tag1.attributes)
    assert_equal([], tag2.attributes)
    text = HTML_Parser::DOM_Nodes::Text.new("abc")
    root.add_child(text)
    assert_equal([tag1, tag2, text], root.children)
  end
  
  #Metoda pro parsovani vstupu pro potreby metody test_complex.
  #* parser - instance tridy HTML_Parser::Parser, jejiz metodu parse ma tato metoda nahradit
  #Vyhazuje vyjimky v pripade spatne utvoreneho dokumentu. V pripade dobre utvoreneho dokumentu vraci koren stromove struktury.
  def parse(parser)
    while !parser.eof?
      parser.parse_char(parser.readchar)
    end
    parser.root
  end
  
  #Komplexni test ulohy HTML parser (#1)
  def test_complex1
    parser = HTML_Parser::Parser.new("test/testfile1.txt", "lib/dictionary.txt")
    begin
      parse(parser)
      fail "Unexpected no exception!"
    rescue Exception => e     
      assert_equal("Unexpected tag mark '<abc>' within null context.", e.message)
    end
  end
  
  #Komplexni test ulohy HTML parser (#2)
  def test_complex2
    parser = HTML_Parser::Parser.new("test/testfile2.txt", "lib/dictionary.txt")
    begin
      parse(parser)
      fail "Unexpected no exception!"
    rescue Exception => e
      assert_equal("Unknown tag mark '<abc>' within '<title>' context.", e.message)
    end
  end
  
  #Komplexni test ulohy HTML parser (#3)
  def test_complex3
    parser = HTML_Parser::Parser.new("test/testfile3.txt", "lib/dictionary.txt")
    begin
      parse(parser)
      fail "Unexpected no exception!"
    rescue Exception => e
      assert_equal("Unexpected tag mark '<i>' within '<head>' context.", e.message)
    end
  end
  
  #Komplexni test ulohy HTML parser (#4)
  def test_complex4
    parser = HTML_Parser::Parser.new("test/testfile4.txt", "lib/dictionary.txt")
    begin
      parse(parser)
      fail "Unexpected no exception!"
    rescue Exception => e
      assert_equal("Unexpected attribute 'neznamyAtribut' within '<body>' context.", e.message)
    end
  end
  
  #Komplexni test ulohy HTML parser (#5)
  def test_complex5
    parser = HTML_Parser::Parser.new("test/testfile5.txt", "lib/dictionary.txt")
    begin
      parse(parser)
      fail "Unexpected no exception!"
    rescue Exception => e
      assert_equal("Unexpected value 'doprava' of attribute 'align' within '<h1>' context.", e.message)
    end
  end
  
  #Komplexni test ulohy HTML parser (#6)
  def test_complex6
    parser = HTML_Parser::Parser.new("test/testfile6.txt", "lib/dictionary.txt")
    begin
      parse(parser)
      fail "Unexpected no exception!"
    rescue Exception => e
      assert_equal("Unexpected character ',' while expecting '<'.", e.message)
    end
  end
  
  #Komplexni test ulohy HTML parser (#7)
  def test_complex7
    parser = HTML_Parser::Parser.new("test/testfile7.txt", "lib/dictionary.txt")
    begin
      parse(parser)
      fail "Unexpected no exception!"
    rescue Exception => e
      assert_equal("Unclosed unpaired tag '<br>'.", e.message)
    end
  end
  
  #Komplexni test ulohy HTML parser (#8)
  def test_complex8
    parser = HTML_Parser::Parser.new("test/testfile8.txt", "lib/dictionary.txt")
    begin
      parse(parser)
      fail "Unexpected no exception!"
    rescue Exception => e
      assert_equal("Unexpected character '*' in opening tag mark near 'di'.", e.message)
    end
  end
  
  #Komplexni test ulohy HTML parser (#9)
  def test_complex9
    parser = HTML_Parser::Parser.new("test/testfile9.txt", "lib/dictionary.txt")
    begin
      parse(parser)
      fail "Unexpected no exception!"
    rescue Exception => e
      assert_equal("Unexpected character '&' in attribute name near 'styl'.", e.message)
    end
  end
  
  #Komplexni test ulohy HTML parser (#10)
  def test_complex10
    parser = HTML_Parser::Parser.new("test/testfile10.txt", "lib/dictionary.txt")
    begin
      parse(parser)
      fail "Unexpected no exception!"
    rescue Exception => e
      assert_equal("Bad tag pairing near '</head>'.", e.message)
    end
  end
  
  #Komplexni test ulohy HTML parser (#11)
  def test_complex11
    parser = HTML_Parser::Parser.new("test/testfile11.txt", "lib/dictionary.txt")
    begin
      root = parse(parser)
      assert_equal(HTML_Parser::DOM_Nodes::Tag, root.class)
      assert_equal("html", root.name)
      assert_equal(1, root.attributes.length)
      assert_equal(2, root.children.length)
    rescue Exception => e
      puts e.message
      fail "Unexpected no exception!"
    end
  end
  
end
