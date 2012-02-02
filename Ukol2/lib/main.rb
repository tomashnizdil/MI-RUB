#Uloha Rectangles

require_relative 'rectangle'

ctverec1 = Rectangles::Ctverec.new(1)
ctverec1.nacti_hodnoty
ctverec2 = Rectangles::Ctverec.new(2)
ctverec2.nacti_hodnoty
Rectangles::vypocti_sjednoceni(ctverec1, ctverec2)
