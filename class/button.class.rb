#
# Author::    Sakyamar https://github.com/sakymar
# License::   MIT Licence
#
# https://github.com/Ousret/Picross-L3S6
#
#* Classe créant un bouton héritant de interfaceObject.
#* Objet de l'interface du plan pouvant être cliqué


load './class/interfaceObject.class.rb'

class Button < InterfaceObject

	private_class_method :new

	attr_accessor :name, :width, :height, :posX, :posY


	#Méthode permettant de savoir l'état de l'objet
	#
	# * *Return value* :
	#   - state : boolean pour savoir si il est actif
	def state
	end


	#Méthode d'initialisation
	#
	#
	# * *Arguments*    :
	#   - +name+ -> nom de l'objet
	#   - +plan+ -> plan auquel l'objet est associé
	#   - +width+ -> largeur de l'objet
	#   - +height+ -> hauteur de l'objet
	#   - +posX+ -> position horizontale à partir du coin gauche de l'objet
	#   - +posY+ -> position verticale à partir du coin gauche de l'objet	
	#   - +options+ -> option supplementaire, transparence , ou autre
	def initialize(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		super(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
	end

	def creer(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		new(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
	end

end
