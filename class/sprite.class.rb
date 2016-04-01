#
# Author::    Ousret https://github.com/Ousret
# License::   MIT Licence
#
# https://github.com/Ousret/Picross-L3S6
#
#* Classe créant un champ de saisie héritant de ObjetGUI.

class Sprite < ObjetGUI

	private_class_method :new

	attr_reader :source, :dimx, :dimy, :etx, :ety

	def initialize(uneDesignation, uneImage, uneDimX, uneDimY, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		super(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		@source, @dimx, @dimy = uneImage, uneDimX, uneDimY
		@etx, @ety = 0, 0
	end

	def Sprite.creer(uneDesignation, uneImage, uneDimX, uneDimY, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		new(uneDesignation, uneImage, uneDimX, uneDimY, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
	end

	def deplacer(unEtatX, unEtatY)
		@etx, @ety = unEtatX, unEtatY
	end

end
