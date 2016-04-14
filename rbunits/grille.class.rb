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
			matrice_non_carre = [[0,0,1,0,1],[1,1,0,1,0]]
			exception = assert_raise(TypeError){Grille.grille(matrice_non_carre)}
			assert_equal("Grille:initialize : la matrice recu n'est pas carré", exception.message)
	end

	#test de creation d'une grille 	avec une martrice 5*5
	def test_grille_5()
	#matrice 5*5
	matrice =[[0,0,1,0,1],[1,1,0,1,0],[0,0,1,0,0],[1,1,0,1,0],[0,1,1,1,1]]
	#indice logique pour la matrice
	indice_haut = [[1, 1],[1, 2],[1, 1, 1],[1, 2],[1, 1]]
	indice_cote = [[1, 1],[2, 1],[1],[2, 1],[4]]

			grille = Grille.grille(matrice)
			assert_equal(grille.indicesHaut(),indice_haut)
			assert_equal(grille.indicesCote(),indice_cote)
	end

    #test de si une case est noir sur une case noir
	def test_estNoir_1()
	#matrice 5*5
	matrice =[[0,0,1,0,1],[1,1,0,1,0],[0,0,1,0,0],[1,1,0,1,0],[0,1,1,1,1]]
			grille = Grille.grille(matrice)
			assert_equal(grille.estNoir?(1,3),true)
	end

     #test de si une case est noir sur une case non noir
	def test_estNoir_2()
	#matrice 5*5
	matrice =[[0,0,1,0,1],[1,1,0,1,0],[0,0,1,0,0],[1,1,0,1,0],[0,1,1,1,1]]
			grille = Grille.grille(matrice)
			assert_equal(grille.estNoir?(2,3),false)
	end

    #test de si une case est noir avec dépassement de la taille du tableau sur x
	def test_estNoir_3_x()
	matrice =[[0,0,1,0,1],[1,1,0,1,0],[0,0,1,0,0],[1,1,0,1,0],[0,1,1,1,1]]
            grille = Grille.grille(matrice)
			exception = assert_raise(RangeError){grille.estNoir?(8,3)}
			assert_equal("coordonée x en dehors de la matrice ", exception.message)
	end

     #test de si une case est noir avec dépassement de la taille du tableau sur y
	def test_estNoir_3_y()
	matrice =[[0,0,1,0,1],[1,1,0,1,0],[0,0,1,0,0],[1,1,0,1,0],[0,1,1,1,1]]
            grille = Grille.grille(matrice)
			exception = assert_raise(RangeError){grille.estNoir?(3,8)}
			assert_equal("coordonée y en dehors de la matrice ", exception.message )
	end

	#test de si le nombre erreur comptabilisé à la creation d'une grille est 0
	def test_nbErreur()
	#matrice 5*5
	matrice =[[0,0,1,0,1],[1,1,0,1,0],[0,0,1,0,0],[1,1,0,1,0],[0,1,1,1,1]]
			grille = Grille.grille(matrice)
			nbErreur = grille.nbErreur() #nombre erreur comptabilisé sur la grille au debut
			assert_equal(nbErreur,0)
	end

	#test de noisir une case sur une bonne case
	def test_noisirCase_1()
	#matrice 5*5
	matrice =[[0,0,1,0,1],[1,1,0,1,0],[0,0,1,0,0],[1,1,0,1,0],[0,1,1,1,1]]
			grille = Grille.grille(matrice)
			nbErreur = grille.nbErreur()
			assert_equal(grille.estNoir?(2,4),true)#test si la case à noisir est bonne
			assert_equal(grille.noirsirCase(2,4),true)#test si le noirsissement de la case s'est bien passé
			assert_equal(nbErreur ,grille.nbErreur())#test si le nombre d'erreur n'a pas été incrémenté
			assert_equal(grille.matriceDeJeu[1][3],1)#test si la case a été bien noirsi
	end


	#test de noisir une case sur une mauvaise case
	def test_noisirCase_2()
	#matrice 5*5
			matrice =[[0,0,1,0,1],[1,1,0,1,0],[0,0,1,0,0],[1,1,0,1,0],[0,1,1,1,1]]
			grille = Grille.grille(matrice)
			nbErreur = grille.nbErreur()
			assert_equal(grille.estNoir?(3,2),false)#test si la case à noisir est pas bonne
			assert_equal(grille.noirsirCase(3,2),false)#test si le noirsissement à été annulé
			assert_equal(nbErreur+1 ,grille.nbErreur())#test si le nombre d'erreur a été incrémenté
			assert_equal(grille.matriceDeJeu[2][1],0)#test si la case n'a pas été noirsi
	end

	#test si une grille est terminé
	def test_terminer()
			#matrice 2*2
			matrice = [[1,0],[0,1]]
			grille  = Grille.grille(matrice)
			assert_equal(grille.terminer?(),false)#test si la grille est terminé avant tout jeu
			grille.noirsirCase(1,1)
			assert_equal(grille.terminer?(),false)#test si la grille est terminé apres noirsissement de la 1er case
			grille.noirsirCase(2,2)
			assert_equal(grille.terminer?(),true)#test si la grille est terminé apres noirsissement de toute les bonnes cases

	end

end
