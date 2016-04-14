# encoding: UTF-8

##
# Auteur HOUSSAM KHALID AL-KASSOUM
# Projet L3 SPI : picross
# Version 0.1 : Date : 23/01/2016
#

require 'rubygems'
require 'active_record'
require_relative 'connectSqlite3.rb'

require_relative 'grille.class.rb'
require_relative 'profile.class.rb'

class Partie<ActiveRecord::Base
	
	#=== Variables d'instance ===
	#@grille	#grille de jeu 
	#@profile   #profile du joueur
	#============================

	#la methode new() est private pour cette classe
	private_class_method :new

    #attr_reader :grille,:profile

	def initialize(grille,profile)#:nodoc:
	
    super()
	self.grilleID  = grille	 #l'id de la grille associé à la partie
	self.profileID = profile	 #l'id du profile associé à la partie
	end


	#=== Methode de classe permetant de creer une partie
	#
	#=== Paramètres:
	#* <b>grille</b>  : grille associé à la partie
	#* <b>profile</b> : le profile associé à la partie
	def Partie.configurer(grille,profile)
		new(grille,profile)
	end

    #=== Methode permetent de sauvegarder une partie
    def sauver()
            self.save
    end 

    #=== Methode de classe permetant de charger une partie
	#
	#=== Paramètres:
	#* <b>id</b>  : l'id de la partie à charger
    def Partie.charger(id)
        return Partie.find_by_id(id)
    end
end
