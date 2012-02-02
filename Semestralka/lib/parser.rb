module HTML_Parser
  require_relative 'dom_nodes'
  require_relative 'dictionary'
  
  #Hlavni trida modulu HTML_Parser, ktera provadi parsovani vstupu a jeho prevod na stromovou reprezentaci
  class Parser
    #Konstanta reprezentujici stav parseru - pocatecni stav
    START = 0
    #Konstanta reprezentujici stav parseru - nacitani oteviraciho tagu
    OPENING_TAG = 1
    #Konstanta reprezentujici stav parseru - nacitani zaviraciho tagu
    CLOSING_TAG = 2
    #Konstanta reprezentujici stav parseru - nacitani nazvu atributu
    ATTRIBUTE_NAME = 3
    #Konstanta reprezentujici stav parseru - nacitani hodnoty atributu
    ATTRIBUTE_VALUE = 4
    #Konstanta reprezentujici stav parseru - nacitani textovych dat
    DATA = 5
    #Koren stromove struktury (atribut pro cteni pro potreby testovani)
    attr_reader :root
  
    #Konstruktor, ktery zajistuje otevreni souboru s analyzovanym html dokumentem a take vytvari novou instanci slovniku
    #* input - vstupni soubor k parsovani
    #* dictionary - externi soubor s definici slovniku
    def initialize(input, dictionary)
      @input = File.open(input, "r")
      @dictionary = Dictionary.new(dictionary)
      @stack = []
      @state = 0
      @data = ""
    end
    
    #Metoda pro cteni znaku ze vstupniho parsovaneho souboru. Vytvorena hlavne pro potreby testovani. 
    #Vraci precteny znak.
    def readchar
      @input.readchar
    end
    
    #Metoda pro zjisteni, jestli je cteni vstupniho parsovaneho souboru u konce. Vytvorena hlavne pro potreby testovani. 
    #Vraci priznak eof.
    def eof?
      @input.eof?
    end
  
    #Metoda, ktera provadi vlastni parsovani vstupu. 
    #Precte a zanalyzuje kazdy znak vstupniho souboru a nakonec vypise hlasku, zda je, nebo neni dobre utvoren, v pripade kladne odpovedi navic jeste vrati koren stromove struktury dokumentu.
    def parse
      while !@input.eof?
        begin
          parse_char(readchar)
        rescue Exception => e
          puts e.message
          puts "Document is not well-formed."
          exit
        end
      end
    
      puts "Document is well-formed. \n\n"
      @input.close
      @root
    end
  
    #Metoda pro vytvareni uzlu tridy Tag ve stromove strukture
    def create_tag
      if @stack.empty?
        if !@data.downcase.eql?("html") || !@root == nil
          raise "Unexpected tag mark '<#{@data}>' within null context."
        end
      elsif !@dictionary.tags.has_key?(@data.downcase)
        raise "Unknown tag mark '<#{@data}>' within '<#{@stack.last.name}>' context."
      elsif !@dictionary.tags[@stack.last.name.downcase].include?(@data.downcase)
        raise "Unexpected tag mark '<#{@data}>' within '<#{@stack.last.name}>' context."
      end
    
      paired = @dictionary.tags[@data] != nil
      tag = DOM_Nodes::Tag.new(@data, paired, @stack.last)
      @stack.push(tag)
      @data = ""
      if @root == nil
        @root = tag
      end
    end
  
    #Metoda pro vytvareni uzlu tridy Attribute ve stromove strukture
    def create_attribute
      name = @stack.pop
      tag = @stack.last.name.downcase
      downcase = name.downcase
      if !@dictionary.attributes[tag].include?(downcase)
        raise "Unexpected attribute '#{name}' within '<#{@stack.last.name}>' context."
      end
      if !@dictionary.values[[tag, downcase]].empty? && !@dictionary.values[[tag, downcase]].include?(@data.downcase)
        raise "Unexpected value '#{@data}' of attribute '#{name}' within '<#{@stack.last.name}>' context."
      end
      attribute = DOM_Nodes::Attribute.new(name, @data)
      @stack.last.add_attribute(attribute)
      @data = ""
    end
    
    #Metoda pro vytvareni textoveho uzlu ve stromove strukture
    def create_text
      if !@data.delete(" ").delete("\t").delete("\n").delete("\r").empty? # data without white spaces
        @stack.last.add_child(DOM_Nodes::Text.new(@data))
      end
      @data = ""
    end
  
    #Hlavni metoda cele tridy, ktera pro precteny znak a aktualni stav parseru vyhodnoti dalsi pokracovani vypoctu. 
    #Pri precteni nektereho z mnoziny pripustnych symbolu pro dany stav zpusobi zmenu stavu s ohledem na dalsi ocekavany znak, pripadne zavola metodu pro vytvoreni prislusneho uzlu. 
    #Pokud dostane pro aktualni stav neocekavany znak, vyvola vyjimku, ktera se odchytava v metode parse.
    #* char - aktualni precteny znak
    def parse_char(char)
      if ["\t", "\r", "\n"].include?(char)
        return
      elsif @state == START
        if char == '<'
          @state = OPENING_TAG
        else
          raise "Unexpected character '#{char}' while expecting '<'."
        end
      elsif @state == OPENING_TAG
        if char == '>'
          if @data.length > 0
            create_tag
            if (@dictionary.tags[@stack.last.name] == nil)
              raise "Unclosed unpaired tag '<#{@stack.last.name}>'."
            end
          end
          @state = DATA
        elsif char == '/'
          @state = CLOSING_TAG
        elsif char == ' '
          if @data.length > 0
            create_tag
          end
          @state = ATTRIBUTE_NAME
        elsif (char >= 'a' && char <= 'z') || (char >= 'A' && char <= 'Z') || (char >= '0' && char <= '9')
          @data << char
        else
          raise "Unexpected character '#{char}' in opening tag mark near '#{@data}'."
        end
      elsif @state == CLOSING_TAG
        if char == '>'
          if !@data.eql?(@stack.pop.name)
            raise "Bad tag pairing near '</#{@data}>'."
          end
          @data = ""
          @state = DATA
        elsif (char >= 'a' && char <= 'z') || (char >= 'A' && char <= 'Z') || (char >= '0' && char <= '9')
          @data << char
        else
          raise "Unexpected character '#{char}' in closing tag mark near '#{@data}'."
        end
      elsif @state == ATTRIBUTE_NAME
        if char == '/' && @data.empty? && !@stack.empty?
          @data = @stack.last.name
          @state = CLOSING_TAG
        elsif char == '=' && !@data.empty? && !@input.eof? && @input.readchar == '"'
          @stack.push(@data)
          @data = ""
          @state = ATTRIBUTE_VALUE
        elsif (char >= 'a' && char <= 'z') || (char >= 'A' && char <= 'Z') || (char >= '0' && char <= '9')
          @data << char
        else
          raise "Unexpected character '#{char}' in attribute name near '#{@data}'."
        end
      elsif @state == ATTRIBUTE_VALUE
        if char == '"'
          create_attribute
          @state = OPENING_TAG
        else
          @data << char
        end
      elsif @state == DATA
        if char == '<'
          create_text
          @state = OPENING_TAG
        else
          @data << char
        end
      end
    end
  
  end
end
