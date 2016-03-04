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

	attr_accessor :width, :height, :title

	#Méthode d'initialisation
	#
	#
	# * *Arguments*    :
	#   - +name+ -> nom de l'objet
	#   - +plan+ -> plan auquel l'objet est associé
	#   - +options+ -> option supplementaire, transparence , ou autre

	def initialize(name, plan, option)
	end


	#Methode retournant le parent de l'objet, ou le plan associé ?
	#
	# * *Return value* :
	#   - Instance parente
	def parent
	end

	#Supprime l'objet
	def destroy
	end

	#Comme Array.each
	#
	# * *Arguments*    :
	#   - +option+ -> critere de recherche
	def InterfaceObject.each(options)
	end

	#Methode pour connaitre toute les instances
	#
	# * *Arguments*    :
	#   - +option+ -> critere de recherche
	#
	# * *Return value* :
	#   - Tableau des intances
	def InterfaceObject.all(options)
	end




end