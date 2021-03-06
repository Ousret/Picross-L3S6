#!/usr/bin/ruby

require 'sqlite3'
require 'gibberish'

# Author:: Victorien https://github.com/Twixbadevil, Ahmed @Ousret https://github.com/Ousret
# License:: MIT Licence
#
# https://github.com/Ousret/Picross-L3S6
#
#* Maintient un registre avec le module SQLite 3
#* Les données sont cryptées à l'aide d'OpenSSL (uniquement valeur de paramètre)
class Registre

	#Indique la valeur de la base de donnee
	#@db
	#Indique la valeur de la cle de criptage
	#@myCrypt

	#Empêche l'utilisation de la mÃ©thode new
	private_class_method :new

	#Méthode de création d'instance de la classe Basedonnee.
	#
	# * *Arguments* :
	# - +unNom+ -> Nom du fichier dans lequel la base de donnee est initialiser
	# * *Returns* :
	# - Une nouvelle instance de la classe Basedonnee.
	def Registre.creer(unNom)
		new(unNom)
	end

	def initialize(unNom) # :nodoc:
		@myCrypt, @db, @fileName = Gibberish::AES::CBC.new('p4ssw0rd'), nil, unNom
		verify
	end

	# Méthode de connexion SQLite3, créer une instance SQLite3.
	def connect
		@db = SQLite3::Database.open @fileName
	end

	# Ferme l'instance SQLite3 si déjà ouvert
	def release
		@db.close if @db != nil
	end

	# Vérifie que la table de registre est déjà créer, sinon créer une nouvelle table
	def verify
		connect
		@db.execute "CREATE TABLE IF NOT EXISTS REGISTRE(id_registre INTEGER PRIMARY KEY, key TEXT, value BLOB)"
		release
	end

	# Encode une valeur dans le format YAML
	def encode(uneValeur)
		@myCrypt.encrypt(uneValeur)
	end

	# Décode un buffer YAML
	def decode(unBuffer)
		@myCrypt.decrypt(unBuffer)
	end

	#Méthode d'ajout de couple parametre valeur dans une base de donnee
	#
	# * *Arguments* :
	# - +uneCle+ -> Nom du paramètre cible
	# - +uneValeur+ -> Contenu
	# * *Returns* :
	# - bool
	def addParam(uneCle, uneValeur)
		if getValue(uneCle) != nil
			return updateParam(uneCle, uneValeur)
		end

		connect

		begin

			stm = @db.prepare "INSERT INTO REGISTRE (id_registre, key, value) VALUES (NULL, ?, ?)"

			stm.bind_param 1, uneCle
			stm.bind_param 2, encode(uneValeur)
			stm.execute

		rescue SQLite3::Exception => e
			puts "Fatal: #{e.to_s}"
			return false
		ensure
			stm.close if stm
			release if @db != nil
		end

		return true
	end

	#Méthode de mise à jour d'un paramètre dans le registre
	#
	# * *Arguments* :
	# - +uneCle+ -> Nom du paramètre cible
	# - +uneValeur+ -> Contenu
	# * *Returns* :
	# - bool
	def updateParam(uneCle, uneValeur)
		if getValue(uneCle) == nil
			return addParam uneCle, uneValeur
		end
		connect

		begin
			stm = @db.prepare "UPDATE REGISTRE SET value =  ? WHERE key = ?"

			stm.bind_param 1, encode(uneValeur)
			stm.bind_param 2, uneCle

			stm.execute
		rescue SQLite3::Exception => e
			puts "<SQLite> #{e}"
			return false
		ensure
			stm.close if stm
			release if @db != nil
		end

		return true
	end

	#Méthode de supression de paramètre dans le registre
	#
	# * *Arguments* :
	# - +uneCle+ -> Nom du paramètre cible
	# * *Returns* :
	# - bool
	def deleteParam(uneCle)
		return false if getValue(uneCle) == nil
		connect

		#Procédure suceptible de lever une exception
		begin
			stm = @db.prepare "DELETE FROM REGISTRE WHERE key = ?"
			stm.bind_param 1, uneCle
			stm.execute
		rescue SQLite3::Exception => e
			puts "<SQLite3> #{e}"
			return false
		ensure
			stm.close if stm
			release if @db != nil
		end

		return true
	end

	#Méthode de lecture d'un paramètre dans le registre
	#
	# * *Arguments* :
	# - +uneCle+ -> Nom du paramètre cible
	# - +uneValeur+ -> Contenu
	# * *Returns* :
	# - bool
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

	private :verify, :release, :connect, :encode, :decode

end
