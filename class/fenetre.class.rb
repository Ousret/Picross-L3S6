#
# Author::    Sakyamar https://github.com/sakymar
# License::   MIT Licence
#
# https://github.com/Ousret/Picross-L3S6
#
#*Classe créant les instances répresentant un plan de la fenetre physique
#* c'est ce que nous voyons. Contient tous les objets de l'interface

class Fenetre < ObjetGUI

	attr_accessor :listeComposant
	private_class_method :new

	def initialize(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY) # :nodoc:
		super(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		@listeComposant = Array.new
	end

	#Création d'une instance Fenêtre
	#   * *Arguments*
	#     - +uneDesignation+ -> Désignation/identificateur du texte
	#     - +unePositionX+ -> Position de la fenêtre sur l'axe X
	#     - +unePositionY+ -> Position de la fenêtre sur l'axe Y
	#     - +unePositionZ+ -> Position de la fenêtre sur l'axe Z
	#     - +uneTailleX+ -> Taille de la fenêtre sur l'axe X
	#     - +uneTailleY+ -> Taille de la fenêtre sur l'axe Z
	#  * *Returns*
	#    - Fenetre
	def Fenetre.creer(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		new(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
	end

	#Ajoute un composant graphique à la fenêtre
	#Tri en fonction de l'index Z
	# * *Returns*
	#   - Array
	def ajouterComposant(*unComposantGUI)
		unComposantGUI.each do |composant|
			@listeComposant.push(composant)
		end
		@listeComposant.sort_by {|composant| composant.posz}
	end

	#Retire un composant graphique à la fenêtre
	# * *Returns*
	#   - Array
	def retirerComposant(unComposantCible)
		@listeComposant.delete(unComposantCible)
	end

	def supprimeTout()
		@listeComposant = Array.new
	end

end
