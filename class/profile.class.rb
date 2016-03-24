# encoding: UTF-8

##
# Auteur HOUSSAM KHALID ALKASSOUM
# Projet L3 SPI : picross
# Version 0.1 : Date : 24/02/2016
#

require 'active_record'
require_relative 'connectSqlite3.rb'


class Profile<ActiveRecord::Base

	# la Classe Profile permet de gerer les  profiles 
	
	#=== Variables d'instance ===
	#@pseudo	#psuedo du joueur
	#@nom		#nom du joueur
	#@prenom	#prenom du joueur
	#@argent	#Monnaie virtuelle
	#============================

	private_class_method :new

	#Définition des methodes d'accèes en lecture
	#attr_reader :pseudo ,:nom  ,:prenom ,:id ,:argent
	#Définition des methodes d'accèes en ecriture
	#attr_writer :pseudo ,:argent


	def initialize(pseudo,nom ,prenom)#:nodoc:

        super()
        self.pseudo = pseudo    #@pseudo	= pseudo
        self.nom    = nom       #@nom	    = nom 
        self.prenom = prenom    #@prenom	= prenom
        self.argent = 0         #@argent	= 0
		
	end

	#=== Methode de classe permetant la creation d'un profile
	#
	#=== Paramètres:
	#* <b>pseudo</b>  	: pseudo du joueur
	#* <b>nom</b>  		: nom du joueur
	#* <b>prenom</b>  	: prenom du joueur
	def Profile.creer(pseudo,nom ,prenom)
		new(pseudo,nom,prenom)
	end

    #=== Methode de classe permetant de sauver un profile
	#
	#=== Paramètres:
	#<b>profile</b> : profile à sauver
    def sauver()
        begin
            self.save
        rescue ActiveRecord::RecordNotUnique => e
            raise ActiveRecord::RecordNotUnique.new("pseudo est deja utiliser")
        end
    end


    #=== Methode de classe permetant de charger un profile
	#
	#=== Paramètres:
	#<b>pseudo</b> : pseudo du profile a charger
    #
    #===Return:
    #<b>return le profile s'il a été trouver si non nil </b>
    def Profile.charger(pseudo)
        return self.find_by_pseudo(pseudo)
    end

    #=== Methode permetant de comparer deux profiles
	#
	#=== Paramètres:
	#<b>pro</b> : profile à comparer
    def eql(pro)
        return (pro.id == self.id and pro.pseudo == self.pseudo and pro.nom == self.nom and pro.prenom == self.prenom and pro.argent == self.argent  )
    end



    #=== Methode permetant de mettre a jour un profile modifié dans la BDA
    #
    #=== Note : 
    #<b>un profile ne peut pas ètre mis ajour s'il n'a jamais été sauver</b>
    def mettreAJour()
        Profile.update(self.id, :pseudo => self.pseudo ,:nom => self.nom ,:prenom => self.prenom,:argent => self.argent)
    end

    


end
