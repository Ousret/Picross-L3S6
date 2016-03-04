load './class/interfaceObject.class.rb'

class Text < InterfaceObject

	attr_writer :contenu, :police

	private_class_method :new

	attr_accessor :nom, :content

	#Méthode d'initialisation
	#
	#
	# * *Arguments*    :
	#   - +name+ -> nom de l'objet
	#   - +plan+ -> plan auquel l'objet est associé
	#   - +options+ -> option supplementaire, transparence , ou autre
	def initialize(uneDesignation, unContenu, uneTaillePolice, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		super(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		@contenu, @police = unContenu, uneTaillePolice
	end

	def creer(uneDesignation, unContenu, uneTaillePolice, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		new(uneDesignation, unContenu, uneTaillePolice, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
	end

end
