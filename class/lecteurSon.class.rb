require 'gosu'

# Author:: Sakymar https://github.com/sakymar
# License:: MIT Licence
# https://github.com/Ousret/Picross-L3S6
#
#*Créer une instance de cette classe en donnant en paramètre le nom du fichier son
#*Utilise la librairie 'gosu' pour gérer la lecture du son
#*Appeler une instance de cette classe initialisera une instance 'Song' de gosu
#*et utilisera la méthode 'play' de celle-ci afin de lire le son
class LecteurSon

	#Indique le nom du fichier a utiliser
	@son
	
	#Empeche l'utilisation de la méthode new pour respecter les demandes de Jacobini
	private_class_method :new
	
	#Methode d'initialisation d'instance de la classe LecteurSon
	#
	#* *Arguments* :
	#	- +nomSon+ -> le nom du fichier  ouvrir 
	#* *Returns* :
	# - Une nouvelle instance de la classe LecteurSon
	def initialize(nomSon)
		@son = Gosu::Song.new(nomSon).play
	end
	
	#Methode de création d'instance de la classe LecteurSon
	#
	#* *Arguments* :
	#	- +nomSon+ -> le nom du fichier  ouvrir 
	#* *Returns* :
	# - Une nouvelle instance de la classe LecteurSon
	def LecteurSon.creer(nomSon)
		new(nomSon)
	end
 
end
