#!/usr/bin/ruby

# Author:: Victorien https://github.com/Twixbadevil
# License:: MIT Licence
#
# https://github.com/Ousret/Picross-L3S6
#
#*Créer une instance de cette classe, permettant a l'utilisateur
#*de creer une base de donnee, ajoute un parametre dans cette base,
#*lis les donnees dans la base.
#*Il y a 5 base de donnee a deux champs, un couple parametre valeur
#*les parametres sont des texts les valeurs prennent sont soit
#*des entiers, des floatants, des chaines de caractere,
#*des booleans ou des blobs
#
require 'sqlite3'

class Basedonnee

	#Indique la valeur de la base de donnee
	@db

	#Empêche l'utilisation de la méthode new
	private_class_method :new

	#Méthode de création d'instance de la classe Basedonnee.
	#
	# * *Arguments* :
	# - +unNom+ -> Nom du fichier dans lequel la base de donnee est initialiser
	# * *Returns* :
	# - Une nouvelle instance de la classe Basedonnee.
	def Basedonnee.Creer(unNom)
		new(unNom)
	end

	#Méthode de création d'instance de la classe Basedonnee.
	#
	# * *Arguments* :
	# - +unNom+ -> Nom du fichier dans lequel la base de donnee est initialiser
	# * *Returns* :
	# - Une nouvelle instance de la classe Basedonnee.
	def initialize(unNom)
		if unNom.class == String
    		@db = SQLite3::Database.new unNom
    		@db.execute "CREATE TABLE IF NOT EXISTS CoupleValParamBlob(Id INTEGER PRIMARY KEY, Parametre TEXT,Valeur BLOB)"
    		@db.execute "CREATE TABLE IF NOT EXISTS CoupleValParamInt(Id INTEGER PRIMARY KEY, Parametre TEXT,Valeur INTEGER)"
    		@db.execute "CREATE TABLE IF NOT EXISTS CoupleValParamFloat(Id INTEGER PRIMARY KEY, Parametre TEXT,Valeur REAL)"
    		@db.execute "CREATE TABLE IF NOT EXISTS CoupleValParamString(Id INTEGER PRIMARY KEY, Parametre TEXT,Valeur VAR_CHAR(100))"
    		@db.execute "CREATE TABLE IF NOT EXISTS CoupleValParamBool(Id INTEGER PRIMARY KEY, Parametre TEXT,Valeur BOOLEAN)"
		else
			puts "Nom invalide"
		end
	end


	#Méthode d'ajout de couple parametre valeur dans une base de donnee
	#
	# * *Arguments* :
	# - +uneBase+ -> nom de la table de la base de donnee dans laquel ajouter les valeurs
	# - +param+ -> parametre a ajouter dans la table
	# - +valeur+ -> valeur a ajouter dans la table
	# * *Returns* :
	# - Vrai si l'ajout a etais realiser avec succes faux sinon
	def ajouteParam(uneBase,param,valeur)
		@db.execute "INSERT INTO #{uneBase} (Parametre,Valeur) VALUES (\"#{param}\", \"#{valeur}\")"
		value = db.last_insert_row_Valeur
		return value == valeur
	end

	#Méthode d'acces en lecture a la base de donnee
	#
	# * *Arguments* :
	# - +uneBase+ -> nom de la table de la base de donnee dans laquel on lis les valeurs
	# - +param+ -> lis la valeur où son parametre vaut param
	# * *Returns* :
	# - La valeur lu dans la table.
	def lireParam(uneBase,param)
		result = nil
		stm = @db.prepare "SELECT Valeur FROM #{uneBase} WHERE Parametre = \"#{param}\""
		rs = stm.execute
		rs.each do |row|
			result = row.join "\s"
		end
		return result
	end

	#Méthode d'encapsulation d'ecriture pour une table de blob
	#
	# * *Arguments* :
	# - +param+ -> parametre a ajouter dans la table
	# - +valeur+ -> valeur a ajouter dans la table
	# * *Returns* :
	# - Vrai si l'ajout a etais realiser avec succes faux sinon
	def ajouteParamBlob(param,valeur)
		return ajouteParam(CoupleValParamBlob,param,valeur)
	end

	#Méthode d'encapsulation de lecture pour une table de blob
	#
	# * *Arguments* :
	# - +param+ -> lis la valeur où son parametre vaut param
	# * *Returns* :
	# - La valeur lu dans la table.
	def lireParamBlob(param)
    	return lireParam(CoupleValParamBlob,param)
	end

	#Méthode d'encapsulation d'ecriture pour une table d'entier
	#
	# * *Arguments* :
	# - +param+ -> parametre a ajouter dans la table
	# - +valeur+ -> valeur a ajouter dans la table
	# * *Returns* :
	# - Vrai si l'ajout a etais realiser avec succes faux sinon
	def ajouteParamInt(param,valeur)
		return ajouteParam(CoupleValParamInt,param,valeur)
	end

	#Méthode d'encapsulation de lecture pour une table d'entier
	#
	# * *Arguments* :
	# - +param+ -> lis la valeur où son parametre vaut param
	# * *Returns* :
	# - La valeur lu dans la table.
	def lireParamInt(param)
		return lireParam(CoupleValParamInt,param)
	end

	#Méthode d'encapsulation d'ecriture pour une table de chaine de caractere
	#
	# * *Arguments* :
	# - +param+ -> parametre a ajouter dans la table
	# - +valeur+ -> valeur a ajouter dans la table
	# * *Returns* :
	# - Vrai si l'ajout a etais realiser avec succes faux sinon
	def ajouteParamString(param,valeur)
		return ajouteParam(CoupleValParamString,param,valeur)
	end

	#Méthode d'encapsulation de lecture pour une table de chaine de caractere
	#
	# * *Arguments* :
	# - +param+ -> lis la valeur où son parametre vaut param
	# * *Returns* :
	# - La valeur lu dans la table.
	def lireParamString(param)
		return lireParam(CoupleValParamString,param)
	end

	#Méthode d'encapsulation d'ecriture pour une table de boolean
	#
	# * *Arguments* :
	# - +param+ -> parametre a ajouter dans la table
	# - +valeur+ -> valeur a ajouter dans la table
	# * *Returns* :
	# - Vrai si l'ajout a etais realiser avec succes faux sinon
	def ajouteParamBool(param,valeur)
		return ajouteParam(CoupleValParamBool,param,valeur)
	end

	#Méthode d'encapsulation de lecture pour une table de boolean
	#
	# * *Arguments* :
	# - +param+ -> lis la valeur où son parametre vaut param
	# * *Returns* :
	# - La valeur lu dans la table.
	def lireParamBool(param)
		return lireParam(CoupleValParamBool,param)
	end

	#Méthode d'encapsulation d'ecriture pour une table de reel
	#
	# * *Arguments* :
	# - +param+ -> parametre a ajouter dans la table
	# - +valeur+ -> valeur a ajouter dans la table
	# * *Returns* :
	# - Vrai si l'ajout a etais realiser avec succes faux sinon
	def ajouteParamFloat(param,valeur)
		return ajouteParam(CoupleValParamFloat,param,valeur)
	end

	#Méthode d'encapsulation de lecture pour une table de reel
	#
	# * *Arguments* :
	# - +param+ -> lis la valeur où son parametre vaut param
	# * *Returns* :
	# - La valeur lu dans la table.
	def lireParamFloat(param)
		return lireParam(CoupleValParamFloat,param)
	end

end
