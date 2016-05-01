
# encoding: UTF-8

##
# Auteur HOUSSAM KHALID AL-KASSOUM
# Projet L3 SPI : picross
# Version 0.1 : Date : 23/01/2016
#

class  Chrono

	# la Classe Chrono permet de gerer un chrono (creation/start/stop)

	#=== Variables d'instance ===
	#@start_time	#date de debut
	#@total_time  	#temps ecoulé depuis le debut
	#@total_time_acc #accumulateur du temp total
	#@nbHeure		#nombre d'heures ecoulé
	#@nbMinute		#nombre de minutes ecoulé
	#@nbSeconde		#nombre de secondes ecoulé
	#@thread        #thread pour le calcule du temp
	#@enPause  		#boolean qui permet de savoir si le chono est en pause
	#============================

	#la methode new() est private pour cette classe
	private_class_method :new

	#Définition des methodes d'accèes en lecture
	attr_reader :total_time , :nbHeure , :nbMinute , :nbSeconde , :total_time_acc


	def initialize(t)#:nodoc:

		@total_time	= 0
		@nbHeure	= 0
		@nbMinute	= 0
		@nbSeconde	= 0
		@total_time_acc = t
		@enPause	= true

	end


	#=== Methode de classe permetant la creation d'un chrono
	#
	#=== Paramètres:
	#* <b>pas de paramètre</b>
	def Chrono.creer()

		new(0)
	end

	#=== Methode de classe permetant la creation d'un chrono
	#
	#=== Paramètres:
	#* <b>pas de paramètre</b>
	def Chrono.charger(t)

		new(t)
	end

	#=== Methode qui permet de demarer le chrono
	#
	#=== Paramètres:
	#* <b>pas de paramètre</b>
	def demarer()
		@start_time = Time.now
		@total_time_acc = @total_time_acc + @total_time
		@enPause	= false
	end

	#=== Methode qui permet de stoper le chrono
	#
	#=== Paramètres:
	#* <b>pas de paramètre</b>
	def arreter()
		@enPause	= true
	end

	#=== Methode qui permet de recuperer le temp totale
	#
	#=== Paramètres:
	#* <b>pas de paramètre</b>
	def getTTotale()
		@total_time = Time.now - @start_time
		@nbSeconde = (@total_time + @total_time_acc).to_i
		@nbHeure   = @nbSeconde / 3600
		@nbMinute  = (@nbSeconde - 3600*@nbHeure)/60
		@nbSeconde = (@nbSeconde - 3600*@nbHeure -@nbMinute*60)

		return (@total_time + @total_time_acc).to_i
	end

	#=== Methode qui permet de redemarer le chrono
	#=== Paramètres:
	#* <b>pas de paramètre</b>
	def reset()

		@total_time	= 0
		@nbHeure	= 0
		@nbMinute	= 0
		@nbSeconde	= 0
		@total_time_acc = 0
	end

	#=== Methode qui permet de stoper le chrono
	#
	#=== Paramètres:
	#* <b>pas de paramètre</b>
	def to_s()

		return (@nbHeure.to_s+" : "+@nbMinute.to_s+" : "+@nbSeconde.to_s)
	end

end
