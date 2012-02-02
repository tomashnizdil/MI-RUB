#Rozsireni tridy String
class String
  #Metoda pro zjisteni, jestli dany string reprezentuje cislo. 
  def is_numeric?
    true if Float(self) rescue false
  end
end

#Rozsireni tridy Float
class Float
  #Metoda pro prevod floatu na integer, pokud je hodnotou cele cislo. 
  #Vraci cele cislo, pokud je hodnota floatu celociselna, jinak vraci samo sebe.
  def to_i_if_int
    to_i == self ? to_i : self
  end
end

#Hlavni modul ulohy Rectangles
module Rectangles
  #Trida Ctverec reprezentujici ctverec
  class Ctverec
    #Atribut reprezentujici delku hrany ctverce
    attr_reader :hrana
  
    #Konstruktor ctverce, ktery nastavuje poradi ctverce - "prvni", "druhy" pro spravny vypis hlasek.
    def initialize(poradi)
      @poradi = poradi
      @cislovky = ["prvniho", "druheho"]
    end
  
    #Metoda pro ziskani delky hrany ctverce a souradnic jeho stredu ze zadaneho pole nebo ze standardniho vstupu.
    #* hodnoty - pole se vstupnimi hodnotami ulohy, vyuziva se pri testovani, jinak je nil a hodnoty se nacitaji ze standardniho vstupu
    def nacti_hodnoty(hodnoty = nil)
      puts "Zadejte delku hrany #{@cislovky[@poradi-1]} ctverce:"
      @hrana = zkontroluj_vstup(hodnoty)
      puts "Zadejte x-ovou souradnici stredu #{@cislovky[@poradi-1]} ctverce:"
      @x = zkontroluj_vstup(hodnoty)
      puts "Zadejte y-ovou souradnici stredu #{@cislovky[@poradi-1]} ctverce:"
      @y = zkontroluj_vstup(hodnoty)
    end
    
    #Metoda overujici spravnost vstupnich dat. 
    #* hodnoty - pole se vstupnimi hodnotami ulohy, vyuziva se pri testovani, pokud je nil, hodnoty se nacitaji ze standardniho vstupu
    #Vraci float hodnotu precteneho cisla, pri zjisteni neciselneho vstupu vypise chybovou hlasku a ukonci beh programu.
    def zkontroluj_vstup(hodnoty)
      if hodnoty == nil
        hodnota = gets
      else
        hodnota = hodnoty.shift
      end
      if (!hodnota.to_s.is_numeric?)
        puts "Spatny vstup."
        exit
      end
      Float(hodnota)
    end
  
    #Metoda vracejici x-ovou souradnici leve hrany ctverce
    def leva
      @x - @hrana/2
    end
  
    #Metoda vracejici x-ovou souradnici prave hrany ctverce
    def prava
      @x + @hrana/2
    end
  
    #Metoda vracejici y-ovou souradnici horni hrany ctverce
    def horni
      @y + @hrana/2
    end
  
    #Metoda vracejici y-ovou souradnici dolni hrany ctverce
    def dolni
      @y - @hrana/2
    end
  
    #Metoda pocitajici obsah ctverce
    def vypocti_obsah
      @hrana * @hrana
    end
  end

  #Metoda pocitajici obsah sjednoceni dvou ctvercu, predavanych jako parametry
  #* ctverec1 - 1. instance typu Ctverec
  #* ctverec2 - 2. instance typu Ctverec
  #Vraci textovou hlasku s resenim.
  def self.vypocti_sjednoceni(ctverec1, ctverec2)
    horizontalni_prekryv, vertikalni_prekryv = -1, -1
    soucet_hran = ctverec1.hrana + ctverec2.hrana
    horizontalni_rozdil_hran = [(ctverec1.leva - ctverec2.prava).abs, (ctverec2.leva - ctverec1.prava).abs]
    vertikalni_rozdil_hran = [(ctverec1.horni - ctverec2.dolni).abs, (ctverec1.dolni - ctverec2.horni).abs]
    if horizontalni_rozdil_hran.max <= soucet_hran
      rozdil_stran = [(ctverec1.leva - ctverec2.leva) > 0, (ctverec1.prava - ctverec2.prava) > 0]
      if (rozdil_stran[0] && rozdil_stran[1]) || (!rozdil_stran[0] && !rozdil_stran[1])
        #ctverce se prekryvaji "normalne"
        horizontalni_prekryv = horizontalni_rozdil_hran.min
      else
        # jeden je uprostred druheho
        horizontalni_prekryv = [ctverec1.hrana, ctverec2.hrana].min
      end
    end
  
    if vertikalni_rozdil_hran.max <= soucet_hran 
      rozdil_stran = [(ctverec1.horni - ctverec2.horni) > 0, (ctverec1.dolni - ctverec2.dolni) > 0]
      if (rozdil_stran[0] && rozdil_stran[1]) || (!rozdil_stran[0] && !rozdil_stran[1])
        vertikalni_prekryv = vertikalni_rozdil_hran.min
      else
        vertikalni_prekryv = [ctverec1.hrana, ctverec2.hrana].min
      end
    end
  
    if horizontalni_prekryv < 0 && vertikalni_prekryv < 0
      text = "Ctverce se ani nedotykaji."
    else
      sjednoceni = ctverec1.vypocti_obsah + ctverec2.vypocti_obsah - horizontalni_prekryv * vertikalni_prekryv
      text = "Obsah sjednoceni dvou ctvercu je #{sjednoceni.to_i_if_int}."
    end
    puts text
    text
  end
end