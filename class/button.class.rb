#
# Author::    Sakyamar https://github.com/sakymar, Ousret https://github.com/Ousret
# License::   MIT Licence
#
# https://github.com/Ousret/Picross-L3S6
#
#* Classe créant un bouton héritant de ObjectGUI
#* Représente un boutton (GUI)
class Boutton < ObjetGUI

	private_class_method :new

	attr_accessor :name, :width, :height, :posX, :posY

	def initialize(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY) # :nodoc:
		super(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
	end

	# Création d'un boutton imprimable sur sortie GL
	# * *Arguments*    :
	#   - +uneDesignation+ -> nom de l'objet
	#   - +unePositionX+ -> plan auquel l'objet est associé
	#   - +unePositionY+ -> largeur de l'objet
	#   - +unePositionZ+ -> hauteur de l'objet
	#   - +uneTailleX+ -> position horizontale à partir du coin gauche de l'objet
	#   - +uneTailleY+ -> position verticale à partir du coin gauche de l'objet
	# * *Returns*
	#   - Boutton
	def Boutton.creer(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		new(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
	end

end
