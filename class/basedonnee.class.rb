#!/usr/bin/ruby

# Author:: Victorien https://github.com/Twixbadevil, Ahmed @Ousret https://github.com/Ousret
# License:: MIT Licence
#
# https://github.com/Ousret/Picross-L3S6
#
#* Maintient un registre avec le module SQLite 3
#* Les données sont cryptées à l'aide d'OpenSSL (uniquement valeur de paramètre)

require 'sqlite3'
load './class/crypt.class.rb'

class Basedonnee

	#Indique la valeur de la base de donnee
	#@db
	#Indique la valeur de la cle de criptage
	#@myCrypt

	#EmpÃªche l'utilisation de la mÃ©thode new
	private_class_method :new

	#MÃ©thode de crÃ©ation d'instance de la classe Basedonnee.
	#
	# * *Arguments* :
	# - +unNom+ -> Nom du fichier dans lequel la base de donnee est initialiser
	# * *Returns* :
	# - Une nouvelle instance de la classe Basedonnee.
	def Basedonnee.creer(unNom)
		new(unNom)
	end

	#MÃ©thode de crÃ©ation d'instance de la classe Basedonnee.
	#
	# * *Arguments* :
	# - +unNom+ -> Nom du fichier dans lequel la base de donnee est initialiser
	# * *Returns* :
	# - Une nouvelle instance de la classe Basedonnee.
	def initialize(unNom)
		if unNom.class == String
			@myCrypt = Crypt.creer("Password")
    	@db = nil
			@fileName = unNom
			verify
		else
			puts "Nom invalide"
		end
	end

	def connect
		@db = SQLite3::Database.open @fileName
	end

	def release
		@db.close
	end

	def verify
		connect
		@db.execute "CREATE TABLE IF NOT EXISTS REGISTRE(id_registre INTEGER PRIMARY KEY, key TEXT, value TEXT)"
		release
	end

	def encode(uneValeur)
		YAML.dump(@myCrypt.encrypt(uneValeur))
	end

	def decode(unBuffer)
		@myCrypt.decrypt(YAML.load(unBuffer))
	end

	private :verify, :release, :connect, :encode, :decode

	#MÃ©thode d'ajout de couple parametre valeur dans une base de donnee
	#
	# * *Arguments* :
	# - +uneTable+ -> nom de la table de la table dans laquel ajouter les valeurs
	# - +param+ -> parametre a ajouter dans la table
	# - +valeur+ -> valeur a ajouter dans la table
	# * *Returns* :
	# - Vrai si l'ajout a etais realiser avec succes faux sinon
	def addParam(uneCle, uneValeur)
		connect
		stm = @db.prepare "INSERT INTO REGISTRE (key, value) VALUES (?, ?)"

		stm.bind_param 1, uneCle
		stm.bind_param 2, encode(uneValeur)

		stm.execute
		stm.close
		release
		return true
	end

	def updateParam(unParametre, uneValeur)
		connect
		stm = @db.prepare "UPDATE REGISTRE SET value =  ? WHERE key = ?"

		stm.bind_param 1, encode(uneValeur)
		stm.bind_param 2, unParametre

		stm.execute
		stm.close
		release
		return true
	end

	#MÃ©thode d'acces en lecture a la base de donnee
	#
	# * *Arguments* :
	# - +uneTable+ -> nom de la table de la table dans laquel on lis les valeurs
	# - +param+ -> lis la valeur oÃ¹ son parametre vaut param
	# * *Returns* :
	# - La valeur lu dans la table.
	def getValue(uneCle)
		connect
		stm = @db.prepare "SELECT value FROM REGISTRE WHERE key = ?"
		stm.bind_param 1, uneCle

		row = stm.execute
		rs = row.next

		# Si aucun résultat n'existe
		if rs == nil
			return nil
		end

		# On recupère la première colonne
		res = rs[0]

		# On ferme l'instance stm pour débloquer la base
		stm.close
		release
		# On renvoie le résultat
		return decode(res)

	end

end
