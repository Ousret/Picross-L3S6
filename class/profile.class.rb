# encoding: UTF-8

##
# Auteur HOUSSAM KHALID AL-KASSOUM
# Projet L3 SPI : picross
# Version 0.1 : Date : 24/02/2016
#


class Profile

	# la Classe Profile permet de gerer les  profiles 
	
	#=== Variables d'instance ===
	#@pseudo	#psuedo du joueur
	#@nom		#nom du joueur
	#@prenom	#prenom du joueur
	#@argent	#Monnaie virtuelle
	#@id		#id du joueur
	#============================

	private_class_method :new
	#Définition des methodes d'accèes en lecture
	attr_reader :pseudo ,:nom  ,:prenom ,:id ,:argent
	#Définition des methodes d'accèes en ecriture
	attr_writer :pseudo ,:argent

	def initialize(pseudo,nom ,prenom,id)#:nodoc:
	
		@pseudo	= pseudo
		@nom	= nom 
		@prenom	= prenom
		@argent	= 0
		@id		= id
		
	end

	#=== Methode de classe permetant la creation d'un profile
	#
	#=== Paramètres:
	#* <b>pseudo</b>  	: pseudo du joueur
	#* <b>nom</b>  		: nom du joueur
	#* <b>prenom</b>  	: prenom du joueur
	#* <b>id</b>  		: id du joueur
	def Profile.creer(pseudo,nom ,prenom,id)
		new(pseudo,nom ,prenom,id)
	end

end