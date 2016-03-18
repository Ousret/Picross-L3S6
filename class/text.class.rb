
class Text < ObjetGUI

	attr_writer :contenu, :police
	private_class_method :new

	def initialize(uneDesignation, unContenu, uneTaillePolice, unePositionX, unePositionY, unePositionZ)
		super(uneDesignation, unePositionX, unePositionY, unePositionZ, -1, -1)
		@contenu, @police = unContenu, uneTaillePolice
	end

	def creer(uneDesignation, unContenu, uneTaillePolice, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		new(uneDesignation, unContenu, uneTaillePolice, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
	end

end
