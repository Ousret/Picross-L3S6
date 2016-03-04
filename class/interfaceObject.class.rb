#
# Author::    Sakyamar https://github.com/sakymar
# License::   MIT Licence
#
# https://github.com/Ousret/Picross-L3S6
#
#*Classe abstraite répresentant les objets de l'interface, un objet générique
#*Tous les objets comme boutons ou textes héritent de InterfaceObject

#load('plan.class.rb')


class InterfaceObject

<<<<<<< HEAD
	attr_accessor :width, :height, :title

	#Méthode d'initialisation
	#
	#
	# * *Arguments*    :
	#   - +name+ -> nom de l'objet
	#   - +plan+ -> plan auquel l'objet est associé
	#   - +options+ -> option supplementaire, transparence , ou autre
=======
>>>>>>> c97fabbc0acbf9778f819d5c2524fa372e48a985

	attr_writer :designation, :posx, :posy, :posz, :taillex, :tailley
	attr_reader :visible, :etat

	private_class_method :new

	#Méthode d'initialisation
	#
	#
	# * *Arguments*    :
	#   - +uneDesignation+ -> nom de l'objet
	#   - +unePositionX+ -> X
	#   - +unePositionY+ -> Y

	def initialize(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		@designation, @posx, @posy, @posz, @taillex, @tailley = uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY
	end

	def creer(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		new(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
	end


end
