#
# Author::    Sakyamar https://github.com/sakymar
# License::   MIT Licence
#
# https://github.com/Ousret/Picross-L3S6
#
#*Classe créant les instances répresentant un plan de la fenetre physique
#* c'est ce que nous voyons. Contient tous les objets de l'interface


class Fenetre < ObjetGUI

	attr_accessor :name

	private_class_method :new
	#Méthode d'initialisation
	#
	#
	# * *Arguments*    :
	#
	#   - +nom+ -> nom du plan
	# 	- +fenetre+ -> fenetre asssocié au plan
	#   - +options+ -> option supplementaire
	def initialize(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		super(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
	end
	
	def Fenetre.creer(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		new(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
	end

	def ajoutComposant(unComposantGUI)
		Array.push(unComposantGUI)
	end

	def retireComposant(unComposantCible)

	end

end
