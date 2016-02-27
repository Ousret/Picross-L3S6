#
# Author::    Sakyamar https://github.com/sakymar
# License::   MIT Licence
#
# https://github.com/Ousret/Picross-L3S6
#
#* Classe créant un bouton héritant de interfaceObject.
#* Objet de l'interface du plan pouvant contenir du texte


load './class/interfaceObject.class.rb'

class Text < InterfaceObject


	#Méthode d'initialisation
	#
	#
	# * *Arguments*    :
	#   - +name+ -> nom de l'objet
	#   - +plan+ -> plan auquel l'objet est associé
	#   - +options+ -> option supplementaire, transparence , ou autre
	def initialize(nom, plan, content, options)

	end

	#Méthode permettant de placer l'objet dans le plan
	#
	#
	# * *Arguments*    :
	#   - +width+ -> largeur de l'objet
	#   - +height+ -> hauteur de l'objet
	#   - +posX+ -> position horizontale à partir du coin gauche de l'objet
	#   - +posY+ -> position verticale à partir du coin gauche de l'objet
	#   - +content+ -> texte de l'objet
	#   - +options+ -> option supplementaire, transparence , ou autre
	def setup(width, height, posX, posY, content, option)
	end



	#Methode permettant de changer le texte de l'objet
	#
	#* *Arguments* :
	# - content : texte de l'objet
	def content
	end

end
