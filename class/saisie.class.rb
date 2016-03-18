#
# Author::    Ousret https://github.com/Ousret
# License::   MIT Licence
#
# https://github.com/Ousret/Picross-L3S6
#
#* Classe créant un champ de saisie héritant de ObjetGUI.

class Saisie < ObjetGUI

	private_class_method :new

	attr_writer :sregexp, :buffer

	def initialize(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		super(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
	end

	def Saisie.creer(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		new(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
	end

	def estValide?
		@buffer.match(@sregexp)
	end

end
