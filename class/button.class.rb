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


	#Méthode d'initialisation
	#
	#
	# * *Arguments*    :
	#   - +name+ -> nom de l'objet
	#   - +plan+ -> plan auquel l'objet est associé
	#   - +options+ -> option supplementaire, transparence , ou autre
	def initialize(name, plan, option)
	end


	#Méthode permettant de placer l'objet dans le plan
	#
	#
	# * *Arguments*    :
	#   - +width+ -> largeur de l'objet
	#   - +height+ -> hauteur de l'objet
	#   - +posX+ -> position horizontale à partir du coin gauche de l'objet
	#   - +posY+ -> position verticale à partir du coin gauche de l'objet
	#   - +options+ -> option supplementaire, transparence , ou autre
	def setup(width, height, posX, posY, option)
	end

	#Méthode permettant de savoir l'état de l'objet
	#
	# * *Return value* :
	#   - state : boolean pour savoir si il est actif
	def state
	end



end
