module HTML_Parser
  #Trida definujici slovnik jazyka HTML
  class Dictionary
    #Konstanta reprezentujici stav parseru pri vytvareni slovniku ze souboru - cteni tagu
    TAG_READING = 1
    #Konstanta reprezentujici stav parseru pri vytvareni slovniku ze souboru - cteni atributu
    ATTR_READING = 2
    #Konstanta reprezentujici stav parseru pri vytvareni slovniku ze souboru - cteni hierarchicke struktury tagu
    HIERARCHY_READING = 3
    
    #Hash pripustnych tagu - pro kazdy tag obsahuje pole moznych potomku
    attr_reader :tags
    #Hash pripustnych atributu - pro kazdy tag obsahuje pole moznych atributu
    attr_reader :attributes
    #Hash pripustnych hodnot atributu - pro kazdou dvojici [tag, atribut] obsahuje pole moznych hodnot, nebo nic pokud jsou hodnoty atributu neomezeny
    attr_reader :values
    
    #Konstruktor, ktery inicializuje zakladni parametry slovniku a spousti metodu create_dictionary
    #* file - externi soubor s definici parsovaneho jazyka
    def initialize(file)
      @file = file
      @tags, @attributes, @values = {}, {}, {}
      create_dictionary
    end
    
    #Metoda vytvarejici vlastni slovnik pomoci nacitani dat z externiho souboru
    def create_dictionary
      state = TAG_READING
      file = File.open(@file, "r")
      file.each_line("\n") { |line| 
        line = line[0...-1] # removing last character - \n
        if line.eql?("//")
          state = HIERARCHY_READING
        elsif line.eql?("/")
          state = TAG_READING
        else
          ids = line.split(" ")
          if state == TAG_READING
            @tag = ids.shift
            @attributes[@tag] = []
            state = ATTR_READING
          elsif state == ATTR_READING
            attribute = ids.shift
            @attributes[@tag] << attribute
            @values[[@tag, attribute]] = ids
          elsif state == HIERARCHY_READING
            tag = ids.shift
            if ids.eql?(["*"])
              @tags[tag] = nil
            else
              @tags[tag] = ids
            end
          end
        end
      }
      file.close
    end
  end
end