#
# Author::    Sakyamar https://github.com/sakymar
# License::   MIT Licence
#
# https://github.com/Ousret/Picross-L3S6
#
#*Classe créant les instances répresentant la fenetre physique

class Fenetreabs < InterfaceObject

	@listeComposant = Array.new

<<<<<<< HEAD
	
	attr_accessor :width, :height, :title

	#Méthode d'initialisation
	#
	#
	# * *Arguments*    :
	#   - +width+ -> largeur de la fenetre
	#   - +height+ -> hauteur de la fenetre
	#   - +title+ -> titre de la fenetre
	#   - +options+ -> option supplementaire, ex:fullscreen , ou autre
	def initialize(width, height, title, options)
	end

	#Methode permettant de fermer la fenetre physique ainsi que stopper la boucle de l'instance
	def close()
	end

	#Methode permettant de changer le titre de la fenetre
	#
	# * *Arguments*    :
	#   - +title+ -> titre de la fenetre
	def title(name)
	end

	#Methode permettant d'afficher physiquement la fenetre
	#
	#* *Arguments* :
	#   - +option+ -> option supplementaire, ex:fullscreen, choix de l'ecran où l'afficher...
	def show(options)
	end


	def isActive?
	end

	def state
	end

	def sound
	end

	def isMuted?
	end
=======
	attr_reader :listeComposant
	private_class_method :new
>>>>>>> c97fabbc0acbf9778f819d5c2524fa372e48a985

	def initialize(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		super(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
	end

	def creer(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
		new(uneDesignation, unePositionX, unePositionY, unePositionZ, uneTailleX, uneTailleY)
	end

	def ajoutComposant(unComposantGUI)
		Array.push(unComposantGUI)
	end

	def retireComposant(unComposantCible)
	end

end
