#Classe représentant un champs Texte statique
#Décrit par une chaîne de caracteres et une taille de police
class Text < ObjetGUI

	attr_accessor :contenu, :police
	private_class_method :new

	def initialize(uneDesignation, unContenu, uneTaillePolice, unePositionX, unePositionY, unePositionZ) # :nodoc:
		super(uneDesignation, unePositionX, unePositionY, unePositionZ, -1, -1)
		@contenu, @police = unContenu, uneTaillePolice
	end

	#Création d'une instance Texte
	#   * *Arguments*
	#     - +uneDesignation+ -> Désignation/identificateur du texte
	#     - +unContenu+ -> Chaine de caractères, le texte cible
	#     - +uneTaillePolice+ -> Taille de la police de caractère en pt
	#     - +unePositionX+ -> Position du texte sur l'axe X
	#     - +unePositionY+ -> Position du texte sur l'axe Y
	#     - +unePositionZ+ -> Position du texte sur l'axe Z
	#  * *Returns*
	#    - Text
	def Text.creer(uneDesignation, unContenu, uneTaillePolice, unePositionX, unePositionY, unePositionZ)
		new(uneDesignation, unContenu, uneTaillePolice, unePositionX, unePositionY, unePositionZ)
	end

end
