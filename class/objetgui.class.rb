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

	def initialize(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY) # :nodoc:
		@designation, @posx, @posy, @posz, @taillex, @tailley = uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY
	end

	# Créer une instance d'un objet imprimable sur la sortie GL
	# * *Arguments*    :
	#   - +uneDesignation+ -> nom de l'objet
	#   - +unePositionX+ -> X
	#   - +unePositionY+ -> Y
	#   - +unePositionZ+ -> Plan sur lequel l'objet sera disposé
	#   - +uneTailleX+ -> Taille axe X en pixel
	#   - +uneTailleY+ -> Taille axe Y en pixel
	def creer(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		new(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
	end

	# Change l'état du composant, actif ou inactif.
	# * *Arguments*    :
	#   - +unNouvelEtat+ -> Vrai/faux
	def setEtat(unNouvelEtat)
		@etat = unNouvelEtat
	end


end
