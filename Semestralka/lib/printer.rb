module HTML_Parser
  #Trida pro vypis stromove struktury HTML dokumentu
  class Printer
    #Metoda nastavujici cilovy soubor pro vystup
    #* file - vystupni soubor, do nehoz se ma zapisovat; pokud je prazdny, pouzije se standardni vystup
    def initialize(file = nil)
      @output = file
    end
    
    #Metoda zajistujici vypis retezce, predavaneho v parametru, do souboru nebo na standardni vystup
    #* data - retezec, ktery se ma vypsat
    def output(data)
      if @output == nil
        print data
      else
        @output.write(data)
      end
    end
    
    #Rekurzivne volana metoda vypisujici podstrom daneho tagu
    #* root - koren vypisovaneho stromu
    #* level - uroven zanoreni ve stromu (pro lepsi citelnost stromu se kazda uroven odsadi o 2 mezery doprava)
    def print_tree(root, level = 0)
      (level*2).times { output ' ' }
      if root.is_a?(DOM_Nodes::Tag)
        output "<" << root.name
        root.attributes.each { |attr| output " " << attr.name << "=\"" << attr.value << "\"" }
        if root.paired
          output ">" << "\n"
          root.children.each { |child| 
            print_tree(child, level+1)
          }
          (level*2).times { output ' ' }
          output "</" << root.name << ">" << "\n"
        else
          output " />" << "\n"
        end
      elsif root.is_a?(DOM_Nodes::Text)
        output root.text << "\n"
      end
    end
  end
end
