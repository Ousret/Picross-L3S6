#
# Author::    Ousret https://github.com/Ousret
# License::   MIT Licence
#
# https://github.com/Ousret/Picross-L3S6
#
#* Classe représentant une image Sprite (PNG) rendable sur GL
class Sprite < ObjetGUI

	private_class_method :new

	attr_reader :source, :dimx, :dimy, :etx, :ety

	def initialize(uneDesignation, uneImage, uneDimX, uneDimY, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY) # :nodoc:
		super(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		@source, @dimx, @dimy = uneImage, uneDimX, uneDimY
		@etx, @ety = 0, 0
	end

	#Création d'une instance Sprite
	#   * *Arguments*
	#     - +uneDesignation+ -> Désignation/identificateur du texte
	#     - +uneImage+ -> Chemin relatif du fichier PNG Sprite (Transparance naturelle uniquement)
	#     - +uneDimX+ -> Nombre de motif sur l'axe X
	#     - +uneDimY+ -> Nombre de motif sur l'axe Y
	#     - +unePositionX+ -> Position du texte sur l'axe X
	#     - +unePositionY+ -> Position du texte sur l'axe Y
	#     - +unePositionZ+ -> Position du texte sur l'axe Z
	#     - +uneTailleX+ -> Taille de l'image sur l'axe X
	#     - +uneTailleY+ -> Taille de l'image sur l'axe Z
	#  * *Returns*
	#    - Sprite
	def Sprite.creer(uneDesignation, uneImage, uneDimX, uneDimY, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		new(uneDesignation, uneImage, uneDimX, uneDimY, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
	end

	#Changement de motif sur le Sprite
	#Simple déplacement de zone de rendu
	#   * *Arguments*
	#     - +unEtatX+ -> Motif axe X
	#     - +unEtatY+ -> Motif axe Y
	#   * *Returns*
	#     - etx, ety
	def deplacer(unEtatX, unEtatY)
		@etx, @ety = unEtatX, unEtatY
	end

end
