#!/usr/bin/ruby

# Class base de donné
# Auteur : Grude Victorien
# Version : 1.1
# Date : 22/01/16

require 'sqlite3'

class Basedonnee

	@db

	private_class_method :new

	def Basedonnee.Creer(unNom)
		new(unNom)
	end

	#Cree une base de donnée dans le fichier "test.db" et une table CoupleValParam
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

	def ajouteParam(uneBase,param,valeur)
		@db.execute "INSERT INTO #{uneBase} (Parametre,Valeur) VALUES (\"#{param}\", \"#{valeur}\")"
		return valeur
	end

	def lireParam(uneBase,param)
		result = nil
		stm = @db.prepare "SELECT Valeur FROM #{uneBase} WHERE Parametre = \"#{param}\""
    rs = stm.execute
    rs.each do |row|
      result = row.join "\s"
    end
    return result
	end

	def ajouteParamBlob(param,valeur)
		return ajouteParam(CoupleValParamBlob,param,valeur)
	end

	def lireParamBlob(param)
    	return lireParam(CoupleValParamBlob,param)
	end

	def ajouteParamInt(param,valeur)
		return ajouteParam(CoupleValParamInt,param,valeur)
	end

	def lireParamInt(param)
		return lireParam(CoupleValParamInt,param)
	end

	def ajouteParamString(param,valeur)
		return ajouteParam(CoupleValParamString,param,valeur)
	end

	def lireParamString(param)
		return lireParam(CoupleValParamString,param)
	end

	def ajouteParamBool(param,valeur)
		return ajouteParam(CoupleValParamBool,param,valeur)
	end

	def lireParamBool(param)
		return lireParam(CoupleValParamBool,param)
	end

	def ajouteParamFloat(param,valeur)
		return ajouteParam(CoupleValParamFloat,param,valeur)
	end

	def lireParamFloat(param)
		return lireParam(CoupleValParamFloat,param)
	end

end
