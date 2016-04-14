# encoding: UTF-8

##
# Auteur HOUSSAM KHALID AL-KASSOUM
# Projet L3 SPI : picross
# Version 0.1 : Date : 23/01/2016
#

require 'active_record'
require_relative 'connectSqlite3.rb'

class  Grille<ActiveRecord::Base

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

    #Définition des methodes d'accèes en lecture
	attr_reader :matriceComparaison ,:matriceDeJeu  ,:indicesHaut  ,:indicesCote ,:nbErreur 

    #Définition des methodes d'accèes en lecture
	attr_writer :matriceComparaison ,:matriceDeJeu  ,:indicesHaut  ,:indicesCote ,:nbErreur 

	def initialize(matrice)#:nodoc:
	
        super()
        
        #gestion des erreur a la  construction de l'objet grille
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

    #=== Methode de classe permetant de sauver un profile
	#
	#=== Paramètres:
	#<b>profile</b> : profile à sauver
    def sauver()
        self.matriceComparaisonBD = Marshal.dump(@matriceComparaison)
		self.indicesHautBD        = Marshal.dump(@indicesHaut)
		self.indicesCoteBD        = Marshal.dump(@indicesCote)
		self.matriceDeJeuBD       = Marshal.dump(@matriceDeJeu)
		self.nbErreurBD           = @nbErreur
        self.save
    end


    #=== Methode de classe permetant de charger un profile
	#
	#=== Paramètres:
	#<b>pseudo</b> : pseudo du profile a charger
    #
    #===Return:
    #<b>return le profile s'il a été trouver si non nil </b>
    def Grille.charger(id)
        grille =  Grille.find_by_id(id)
        grille.matriceComparaison  = Marshal.load(grille.matriceComparaisonBD)
		grille.indicesHaut         = Marshal.load(grille.indicesHautBD)
		grille.indicesCote         = Marshal.load(grille.indicesCoteBD)
		grille.matriceDeJeu        = Marshal.load(grille.matriceDeJeuBD)
		grille.nbErreur            = grille.nbErreurBD
        return grille
    end


    #=== Methode permetant de mettre a jour un profile modifié dans la BDA
    #
    #=== Note : 
    #<b>un profile ne peut pas ètre mis ajour s'il n'a jamais été sauver</b>
    def mettreAJour()
        Grille.update(self.id,
                      :matriceComparaisonBD => Marshal.dump(self.matriceComparaison) ,
                      :indicesHautBD => Marshal.dump(self.indicesHaut) ,
                      :indicesCoteBD => Marshal.dump(self.indicesCote),
                      :matriceDeJeuBD  => Marshal.dump(self.matriceDeJeu ),
                      :nbErreurBD  => self.nbErreur)
    end

    #=== Methode permetant de comparer deux profiles
	#
	#=== Paramètres:
	#<b>pro</b> : profile à comparer
    def eql(g)
        return (g.id                    == self.id                  and
                g.matriceComparaison    == self.matriceComparaison  and 
                g.indicesHaut           == self.indicesHaut         and 
                g.indicesCote           == self.indicesCote         and 
                g.nbErreur              == self.nbErreur  )
    end
end
