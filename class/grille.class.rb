# encoding: UTF-8

##
# Auteur HOUSSAM KHALID AL-KASSOUM
# Projet L3 SPI : picross
# Version 0.1 : Date : 23/01/2016
#


class Grille

	# la Classe Grille permet d'encapsuler une matrice de boolean et de lui ajouter des fonctionnalitées
	# class qui renvoi une grille jouable à partir d'une matrice de boolean
	# cette classe ne gère que les matrice carre

	
	
	#=== Variables d'instance ===
	#@matriceComparaison	#matrice de comparaison ,on y coche aucune case
    #@matriceDeJeu  		#matrice sur laquelle le joueur interagit
	#@indicesHaut			#indices logique du haut de la grille
	#@indicesCote			#indices logique du coté de la grille
    #@nbErreur      		#compte le nombre d'erreur du joueur
	#============================

	#la methode new() est private pour cette classe
	private_class_method :new 

	def initialize(matrice)#:nodoc:
	
		if matrice==nil
			raise TypeError.new("Grille:initialize : la matrice recu est vide")

		elsif matrice.length != matrice[0].length
			print("\n longeur : "+matrice.length.to_s+" largeur : "+matrice[0].length.to_s+"\n");
			raise TypeError.new("Grille:initialize : la matrice recu n'est pas carré")
		end 

		@matriceComparaison	= matrice
		@indicesHaut 	= Array.new(@matriceComparaison.length) { Array.new() }
		@indicesCote	= Array.new(@matriceComparaison.length) { Array.new() }
		@matriceDeJeu   = Array.new(@matriceComparaison.length,0){Array.new(@matriceComparaison.length,0)}

		self.calculeIndiceCote()
		self.calculeIndiceHaut()

		@nbErreur=0
		
	end

	
	#=== Methode de classe permetant l'initialisation ...
	#
	#=== Paramètres:
	#* <b>matrice</b>  : matrice de jeu
	def Grille.grille(matrice)

		new(matrice)
		
	end

	#Définition des methodes d'accèes en lecture
	attr_reader :matriceComparaison ,:matriceDeJeu  ,:indicesHaut  ,:indicesCote ,:nbErreur 


	#=== Methode qui permet de calculer les indices logique du haut 
	#
	#=== Paramètres:
	#* <b>pas de paramètre</b>
	def calculeIndiceCote()

		nbCaseNoirConsecutif = 0 #variable qui permet de gerer les cases noir consecutifs
		x=0
		while x < @matriceComparaison.length #--------------------------------------on parcours chaque ligne
			y=0
			while (y < @matriceComparaison.length) #----------------------------------colonne par colonne
				if(@matriceComparaison[x][y]==1) then #---------------------------------------si on tombe sur une case noir
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
		while y < @matriceComparaison.length #------------------------------------on parcours chaque colonne
			x=0
			while x < @matriceComparaison.length #----------------------------------ligne par ligne
				if(@matriceComparaison[x][y] == 1) then #---------------------------------------si on tombe sur une case noir
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

	#cette ligne doit resté en commentaire durant le devellopement
	#private_class_method :calculeIndiceCote ,:calculeIndiceHaut


	#=== Methode qui permet d'afficher une grille
	#
	#=== Paramètres :
	#* <b>pas de paramètres</b>
	def afficher(mat)
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
			while x < mat.length
				print(mat[x])
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
    #=== Return :
    #return true si la case [x][y] est noir si non false
    def estNoir?(x,y)
        x=x-1   #on decrémente les indices de -1 parce que le tableau commence à l'indice 0
        y=y-1
        if x > matriceComparaison.length
			raise RangeError.new("coordonée x en dehors de la matrice ")
        end
        if y > matriceComparaison.length
			raise RangeError.new("coordonée y en dehors de la matrice ")
        end

        return @matriceComparaison[x][y] == 1
    end

    #=== Methode qui permet de noircire une case 
	#
	#=== Paramètres :
	#* <b>x</b>:coordonée x : la ligne
    #* <b>x</b>:coordonée y : la colonne
    #=== Return :
    #return true si la case [x][y] été noirsi si non false
    def noirsirCase(x,y)

        if estNoir?(x,y)==false		#si la case selectionné n'est pas correcte
        	@nbErreur += 1 			#on incremente le nombre d'erreur du joueur
        	return false			#on retourne false
    	else						#si non si la case selectionné est corecte 

    		@matriceDeJeu[x-1][y-1] = 1 	# on noirsi la case selectionné
    		return true					#retourn true
    	end
    end


    #=== Methode qui permet de savoir si la grille est terminé
	#
	#=== Paramètres :
    #=== Return :
    #return true si la grille est terminé(toutes les bonnes cases ont été noirsi) si non false
    def terminer?()
    	x=0
        while x < @matriceComparaison.length
				if (@matriceComparaison[x] != @matriceDeJeu[x])
						return false
				end
				x+=1
		end
		return true
    end
end
