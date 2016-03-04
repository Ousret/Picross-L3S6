#
# Author::    Sakyamar https://github.com/sakymar
# License::   MIT Licence
#
# https://github.com/Ousret/Picross-L3S6
#
#*Classe créant les instances répresentant la fenetre physique

class Fenetreabs < InterfaceObject

	@listeComposant = Array.new

	attr_reader :listeComposant
	private_class_method :new

	def initialize(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		super(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
	end

	def creer(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		new(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
	end

	def ajoutComposant(unComposantGUI)
		Array.push(unComposantGUI)
	end

	def retireComposant(unComposantCible)
	end

end
