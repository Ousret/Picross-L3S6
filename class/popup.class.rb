#
# Author::    Ousret https://github.com/Ousret
# License::   MIT Licence
#
# https://github.com/Ousret/Picross-L3S6
#

class PopUp < Fenetre

	private_class_method :new

	def initialize(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY) # :nodoc:
		super(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
	end

	def PopUp.creer(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		new(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
	end

end
