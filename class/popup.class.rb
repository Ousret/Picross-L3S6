#
# Author::    Ousret https://github.com/Ousret
# License::   MIT Licence
#
# https://github.com/Ousret/Picross-L3S6
# Représentation d'une fenêtre fils
class PopUp < Fenetre

	private_class_method :new

	def initialize(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY) # :nodoc:
		super(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
	end

	#Création d'une instance PopUp
	#   * *Arguments*
	#     - +uneDesignation+ -> Désignation/identificateur du texte
	#     - +unePositionX+ -> Position PopUp sur l'axe X
	#     - +unePositionY+ -> Position PopUp sur l'axe Y
	#     - +unePositionZ+ -> Position PopUp sur l'axe Z
	#     - +uneTailleX+ -> Taille de la PopUp sur l'axe X
	#     - +uneTailleY+ -> Taille de la PopUp sur l'axe Z
	#  * *Returns*
	#    - PopUp
	def PopUp.creer(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		new(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
	end

end
