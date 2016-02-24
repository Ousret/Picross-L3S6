#
# Author::    Sakyamar https://github.com/sakymar
# License::   MIT Licence
#
# https://github.com/Ousret/Picross-L3S6
#
#*Classe créant les instances répresentant un plan de la fenetre physique
#* c'est ce que nous voyons. Contient tous les objets de l'interface


class Plan

	#Méthode d'initialisation
	#
	#
	# * *Arguments*    :
	#
	#   - +nom+ -> nom du plan
	# 	- +fenetre+ -> fenetre asssocié au plan
	#   - +options+ -> option supplementaire
	def initialize(name, fenetre, options)
	end

	# Methode permettant de récuperer la touche qui vient d'etre levé
	#* *Returns* :
	# - Code correspondant a la touche
	def keyUp
	end

	# Methode permettant de récuperer la touche qui vient d'etre appuyé
	#* *Returns* :
	# - Code correspondant a la touche
	def keyDown
	end

	# Methode permettant de récuperer le clique de la souris
	#* *Returns* :
	# - Code correspondant au click gauche
	def click
	end

	#background ?
	def draw
	end

	# Methode permettant de récuperer la position de la souris
	#* *Returns* :
	# - Axe x et y
	def cursor
	end

end