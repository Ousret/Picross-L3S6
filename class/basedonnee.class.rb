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

	def ajouteParamBlob(param,valeur)

		@db.execute "INSERT INTO CoupleValParamBlob (Parametre,Valeur) VALUES (\"#{param}\", \"#{valeur}\")"
		return valeur

	end

	def lireParamBlob(param)
		result = nil
		stm = @db.prepare "SELECT Valeur FROM CoupleValParamBlob WHERE Parametre = \"#{param}\""
    	rs = stm.execute 
    	rs.each do |row|
        	result = row.join "\s"
    	end 
    	return result
	end

	def ajouteParamInt(param,valeur)

		@db.execute "INSERT INTO CoupleValParamInt (Parametre,Valeur) VALUES (\"#{param}\", \"#{valeur}\")"
		return valeur

	end

	def lireParamInt(param)
		result = nil
		stm = @db.prepare "SELECT Valeur FROM CoupleValParamInt WHERE Parametre = \"#{param}\""
    	rs = stm.execute 
    	rs.each do |row|
        	result = row.join "\s"
    	end 
    	return result
	end

	def ajouteParamString(param,valeur)

		@db.execute "INSERT INTO CoupleValParamString (Parametre,Valeur) VALUES (\"#{param}\", \"#{valeur}\")"
		return valeur

	end

	def lireParamString(param)
		result = nil
		stm = @db.prepare "SELECT Valeur FROM CoupleValParamString WHERE Parametre = \"#{param}\""
    	rs = stm.execute 
    	rs.each do |row|
        	result = row.join "\s"
    	end 
    	return result
	end

	def ajouteParamBool(param,valeur)

		@db.execute "INSERT INTO CoupleValParamBool (Parametre,Valeur) VALUES (\"#{param}\", \"#{valeur}\")"
		return valeur

	end

	def lireParamBool(param)
		result = nil
		stm = @db.prepare "SELECT Valeur FROM CoupleValParamBool WHERE Parametre = \"#{param}\""
    	rs = stm.execute 
    	rs.each do |row|
        	result = row.join "\s"
    	end 
    	return result
	end

	def ajouteParamFloat(param,valeur)

		@db.execute "INSERT INTO CoupleValParamFloat (Parametre,Valeur) VALUES (\"#{param}\", \"#{valeur}\")"
		return valeur

	end

	def lireParamFloat(param)
		result = nil
		stm = @db.prepare "SELECT Valeur FROM CoupleValParamFloat WHERE Parametre = \"#{param}\""
    	rs = stm.execute 
    	rs.each do |row|
        	result = row.join "\s"
    	end 
    	return result
	end

end 

