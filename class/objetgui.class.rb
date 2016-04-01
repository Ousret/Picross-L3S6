#
# Author::    Sakyamar https://github.com/sakymar, Ousret https://github.com/Ousret
# License::   MIT Licence
#
# https://github.com/Ousret/Picross-L3S6
#
#*Classe abstraite répresentant les objets de l'interface, un objet générique
#*Tous les objets comme boutons ou textes héritent de InterfaceObject

class ObjetGUI

	attr_accessor :designation, :posx, :posy, :posz, :taillex, :tailley
	attr_reader :visible, :etat

	private_class_method :new

	#Méthode d'initialisation
	#
	#
	# * *Arguments*    :
	#   - +uneDesignation+ -> nom de l'objet
	#   - +unePositionX+ -> X
	#   - +unePositionY+ -> Y

	def initialize(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		@designation, @posx, @posy, @posz, @taillex, @tailley = uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY
	end

	def creer(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		new(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
	end

	def setEtat(unNouvelEtat)
		@etat = unNouvelEtat
	end


end
