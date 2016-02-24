#
# Author::    Sakyamar https://github.com/sakymar
# License::   MIT Licence
#
# https://github.com/Ousret/Picross-L3S6
#
#*Classe créant les instances répresentant la fenetre physique


class Fenetreabs

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

	def fullscreen
	end

	def isFullScreen?
	end

	def showFps
	end

	#background ?
	def draw
	end

end