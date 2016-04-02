#
# Author::    Ousret https://github.com/Ousret
# License::   MIT Licence
#
# https://github.com/Ousret/Picross-L3S6
#
#* Classe représentant un champs de saisie rendable sur GL
class Saisie < ObjetGUI

	private_class_method :new
	attr_writer :sregexp, :buffer

	def initialize(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY) # :nodoc:
		super(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
	end

	# Création d'un objet champs de saisie
	# * *Arguments*
	#   - +uneDesignation+ -> Designation du champs de saisie (Identificateur)
	#   - +unePositionX+ -> Position axe X relatif à la fenêtre
	#   - +unePositionY+ -> Position axe Y relatif à la fenêtre
	#   - +unePositionZ+ -> Positionnement sur plan Z
	#   - +uneTailleX+ -> Taille en pixel X
	#   - +uneTailleY+ -> Taille en pixel Y
	# * *Returns*
	#   - Saisie
	def Saisie.creer(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		new(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
	end

	# Vérifie si la saisie est valide
	# * *Returns*
	#   - bool
	def estValide?
		@buffer.match(@sregexp)
	end

end
