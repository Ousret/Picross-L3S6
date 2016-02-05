# encoding: UTF-8

##
# Auteur HOUSSAM KHALID AL-KASSOUM
# Projet L3 SPI : picross
# Version 0.1 : Date : 23/01/2016
#

require 'test/unit'
load './class/grille.class.rb'

class TestGrille < Test::Unit::TestCase

	#test de creation d'une grille 	avec nil comme paramètre
	def test_grille_nil()

			exception = assert_raise(TypeError){Grille.grille(nil)}
			assert_equal("Grille:initialize : la matrice recu est vide", exception.message)
	end

	#test de creation d'une grille 	avec une matrice non carree
	def test_grille_non_carree()
			matrice_non_carre = [[false,false,true,false,true],[true,true,false,true,false]]
			exception = assert_raise(TypeError){Grille.grille(matrice_non_carre)}
			assert_equal("Grille:initialize : la matrice recu n'est pas carré", exception.message)
	end

	#test de creation d'une grille 	avec une martrice 5*5
	def test_grille_5()
	#matrice 5*5
	matrice =[[false,false,true,false,true],[true,true,false,true,false],[false,false,true,false,false],[true,true,false,true,false],[false,true,true,true,true]]
	#indice logique pour la matrice
	indice_haut = [[1, 1],[1, 2],[1, 1, 1],[1, 2],[1, 1]]
	indice_cote = [[1, 1],[2, 1],[1],[2, 1],[4]]

			grille = Grille.grille(matrice)
			assert_equal(grille.indicesHaut(),indice_haut)
			assert_equal(grille.indicesCote(),indice_cote)
	end

end
