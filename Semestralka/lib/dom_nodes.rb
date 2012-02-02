#Modul HTML_Parser - hlavni modul ulohy HTML Parser
module HTML_Parser
  #Modul uzlu document object modelu
  module DOM_Nodes
    #Trida reprezentujici tag v jazyce HTML
    class Tag
      #Nazev tagu
      attr_reader :name
      #Pole atributu tagu
      attr_reader :attributes
      #Pole potomku tagu
      attr_reader :children
      #Binarni hodnota parovy/neparovy tag
      attr_reader :paired
  
      #Konstruktor nastavujici zakladni promenne instance podle predavanych parametru
      #* name - nazev tagu
      #* paired - binarni hodnota parovy/neparovy tag
      #* parent - odkaz na rodice tagu
      def initialize(name, paired, parent)
        @name, @paired, @parent = name, paired, parent
        if (@parent != nil)
          @parent.add_child(self)
        end
        @children, @attributes = [], []
      end
  
      #Metoda pro pridani potomka uzlu
      #* child - pridavany potomek
      def add_child(child)
        @children << child
      end
  
      #Metoda pro pridani atributu do seznamu atributu
      #* attribute - pridavany atribut
      def add_attribute(attribute)
        @attributes << attribute
      end
    end

    #Trida reprezentujici atribut nejakeho tagu v jazyce HTML
    class Attribute
      #Nazev atributu
      attr_reader :name
      #Hodnota atributu
      attr_reader :value
    
      #Konstruktor, ktery nastavuje nazev a hodnotu atributu
      #* name - nazev atributu
      #* value - hodnota atributu
      def initialize(name, value)
        @name, @value = name, value
      end
    end

    #Trida reprezentujici textova data obsazena v HTML dokumentu
    class Text
      #Obsah textoveho prvku
      attr_reader :text
      
      #Konstruktor nastavujici textova data prvku
      #* text - obsah textoveho prvku
      def initialize(text)
        @text = text
      end
    end
  end
end