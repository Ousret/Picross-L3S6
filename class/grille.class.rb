# encoding: UTF-8

##
# Auteur HOUSSAM KHALID AL-KASSOUM
# Projet L3 SPI : picross
# Version 0.1 : Date : 23/01/2016
#


class Grille

	# la Classe GrilleDeJeu ajoute des attributs et des fonctionnalitées à une matrice simple
	#class qui renvoi une grille jouable à partir d'une matrice de boolean
	#cette classe ne gère que les matrice carre

	
	
	#=== Variables d'instance ===
	#@matrice		#matrice de jeu 
	#@indicesHaut	#indices logique du haut de la grille
	#@indicesCote	#indices logique du coté de la grille
	#============================

	#la methode new() est private pour cette classe
	private_class_method :new,:calculeIndiceHaut,:calculeIndiceCote

	def initialize(matrice)#:nodoc:
	
		if matrice==nil
			raise TypeError.new("Grille:initialize : la matrice recu est vide")

		elsif matrice.length != matrice[0].length
			raise TypeError.new("Grille:initialize : la matrice recu n'est pas carré")
		end 

		@matrice		= matrice
		@indicesHaut 	= Array.new(@matrice.length) { Array.new() }
		@indicesCote	= Array.new(@matrice.length) { Array.new() }
		
		self.calculeIndiceCote()
		self.calculeIndiceHaut()
		
	end

	
	#=== Methode de classe permetant l'initialisation ...
	#
	#=== Paramètres:
	#* <b>matrice</b>  : matrice de jeu
	def Grille.grille(matrice)

		new(matrice)
		
	end

	#Définition des methodes d'accèes en lecture
	attr_reader :matrice  ,:indicesHaut  ,:indicesCote


	#=== Methode qui permet de calculer les indices logique du haut 
	#
	#=== Paramètres:
	#* <b>pas de paramètre</b>
	def calculeIndiceCote()

		nbCaseNoirConsecutif = 0 #variable qui permet de gerer les cases noir consecutifs
		x=0
		while x < @matrice.length #--------------------------------------on parcours chaque ligne
			y=0
			while (y < @matrice.length) #----------------------------------colonne par colonne
				if(@matrice[x][y]) then #---------------------------------------si on tombe sur une case noir
					nbCaseNoirConsecutif +=1 #--------------------------------------on incremente `nbCaseNoirConsecutif`
				elsif(nbCaseNoirConsecutif != 0 ) then #-----------------------si non si `nbCaseNoirConsecutif` est differant de zero
						@indicesCote[x].push(nbCaseNoirConsecutif) #------------------on rajoute le nombre de case noir dans le tableau des indices du coté
						nbCaseNoirConsecutif = 0 #------------------------------------et on remet le `nbCaseNoirConsecutif` à zero
				end
				y+=1
			end

			if(nbCaseNoirConsecutif != 0 ) then #---------------------------si on a terminé le parcour des ligne et que `nbCaseNoirConsecutif` est differant de zero
				@indicesCote[x].push(nbCaseNoirConsecutif) #-------------------on rajoute le nombre de case noir dans le tableau des indices du coté
				nbCaseNoirConsecutif = 0 #-------------------------------------et on remet le `nbCaseNoirConsecutif` à zero
			end

			x+=1
		end

	end

	#=== Methode qui permet de calculer les indices logique du coté
	#
	#=== Paramètres:
	#* <b>pas de paramètre</b>
	def calculeIndiceHaut()
		
		nbCaseNoirConsecutif = 0 #variable qui permet de gerer les cases noir consecutifs
		y=0
		while y < @matrice.length #------------------------------------on parcours chaque colonne
			x=0
			while x < @matrice.length #----------------------------------ligne par ligne
				if(@matrice[x][y]) then #---------------------------------------si on tombe sur une case noir
					nbCaseNoirConsecutif +=1 #--------------------------------------on incremente `nbCaseNoirConsecutif`
				elsif(nbCaseNoirConsecutif != 0 ) then #-----------------------si non si `nbCaseNoirConsecutif` est differant de zero
						@indicesHaut[y].push(nbCaseNoirConsecutif) #------------------on rajoute le nombre de case noir dans le tableau des indices du haut
						nbCaseNoirConsecutif = 0 #------------------------------------et on remet le `nbCaseNoirConsecutif` à zero
				end
				x+=1
			end

			if(nbCaseNoirConsecutif != 0 ) then #---------------------------si on a terminé le parcour des colonne et que `nbCaseNoirConsecutif` est differant de zero
				@indicesHaut[y].push(nbCaseNoirConsecutif) #-------------------on rajoute le nombre de case noir dans le tableau des indices du haut
				nbCaseNoirConsecutif = 0 #-------------------------------------et on remet le `nbCaseNoirConsecutif` à zero
			end
			
			y+=1
		end

	end



	#=== Methode qui permet d'afficher une grille
	#
	#=== Paramètres :
	#* <b>pas de paramètres</b>
	def afficher()
		x=0
		#affichache de la grille du haut
			print("---------------------------affichache de la grille du haut---------------------------\n")
			while x < @indicesHaut.length
				print(@indicesHaut[x])
				print("\n")
				x+=1
			end
		x=0
		#affichage de la matrice
		print("---------------------------affichage de la matrice---------------------------\n")
			while x < @matrice.length
				print(@matrice[x])
				print("\n")
				x+=1
			end
		x=0
		#affichage de la grille du coté
		print("---------------------------affichage de la grille du coté---------------------------\n")
			while x < @indicesCote.length
				print(@indicesCote[x])
				print("\n")
				x+=1
			end

	end

    
    #=== Methode qui permet de savoir si une case est noir 
	#
	#=== Paramètres :
	#* <b>x</b>:coordonée x : la ligne
    #* <b>x</b>:coordonée y : la colonne
    #=== Paramètres :
    #return true si la case [x][y] est noir si non false
    def estNoir?(x,y)
        x=x-1   #on decrémente les indices de -1 parce que le tableau commence à l'indice 0
        y=y-1
        if x > matrice.length
			raise RangeError.new("coordonée x en dehors de la matrice")
        end
        if y > matrice.length
			raise RangeError.new("coordonée y en dehors de la matrice")
        end
        return @matrice[x][y]
    end
end
