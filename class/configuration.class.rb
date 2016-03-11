# encoding: UTF-8

##
# Auteur HOUSSAM KHALID AL-KASSOUM
# Projet L3 SPI : picross
# Version 0.1 : Date : 23/01/2016
#

require_relative 'grille.class.rb'
require_relative 'profile.class.rb'

class Configuration

	# la Classe GrilleDeJeu ajoute des attributs et des fonctionnalitées à une matrice simple
	
	
	#=== Variables d'instance ===
	#@grille	#grille de jeu 
	#@profile #profile du joueur
	#============================

	#la methode new() est private pour cette classe
	private_class_method :new
    attr_reader :grille,:profile

	def initialize(grille,profile)#:nodoc:
	
	@grille  = grille	#traitement sur la matrice de base pour obtenir la grille de jeu final
	@profile = profile	#on associ la grille a un profile
	end


	#=== Methode de classe permetant l'initialisation
	#
	#=== Paramètres:
	#* <b>matrice</b>  : matrice de jeu
	def Configuration.configurer(grille,profile)
		new(grille,profile)
	end

end
