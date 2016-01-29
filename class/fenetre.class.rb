 
 require 'gosu'

# Author:: Sakymar https://github.com/sakymar
# License:: MIT Licence
# https://github.com/Ousret/Picross-L3S6
#
#*Créer une instance de cette classe 
#*Utilise la librairie 'gosu' pour gérer la fenetre
#*Appeler une instance de cette classe initialisera une instance 'Window' de gosu
 class GameWindow < Gosu::Window
  
	#Methode d'initialisation d'instance de la classe GameWindow héritant de
	#de la classe Window de 'gosu'
	# 
	#* *Returns* :
	# - Une nouvelle instance de la classe GameWindow
	def initialize
		super 100,100
	end
	
	def update
	end

	def draw
	end
end