#
# Author::    Sakyamar https://github.com/sakymar
# License::   MIT Licence
#
# https://github.com/Ousret/Picross-L3S6
#
#*Classe créant les instances répresentant un plan de la fenetre physique
#* c'est ce que nous voyons. Contient tous les objets de l'interface

class Fenetre < ObjetGUI

	attr_writer :listeComposant
	private_class_method :new

	def initialize(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		super(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		@listeComposant = Array.new
	end

	def Fenetre.creer(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		new(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
	end

	def ajouterComposant(unComposantGUI)
		@listeComposant.push(unComposantGUI)
	end

	def retirerComposant(unComposantCible)
		@listeComposant.delete(unComposantCible)
	end

end
