
class Text < ObjetGUI

	attr_accessor :contenu, :police
	private_class_method :new

	def initialize(uneDesignation, unContenu, uneTaillePolice, unePositionX, unePositionY, unePositionZ)
		super(uneDesignation, unePositionX, unePositionY, unePositionZ, -1, -1)
		@contenu, @police = unContenu, uneTaillePolice
	end

	def Text.creer(uneDesignation, unContenu, uneTaillePolice, unePositionX, unePositionY, unePositionZ)
		new(uneDesignation, unContenu, uneTaillePolice, unePositionX, unePositionY, unePositionZ)
	end

end
