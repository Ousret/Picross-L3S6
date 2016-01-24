#!/usr/bin/ruby

# Class base de donné
# Auteur : Grude Victorien
# Version : 1.0
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
    		@db.execute "CREATE TABLE IF NOT EXISTS CoupleValParam(Id INTEGER PRIMARY KEY, Parametre TEXT,Valeur BLOB)"
		else
			puts "Nom invalide"
		end
	end

	def ajouteParam(param,valeur)

		@db.execute "INSERT INTO CoupleValParam (Parametre,Valeur) VALUES (\"#{param}\", \"#{valeur}\")"
		return valeur

	end

	def lireParam(param)
		result = nil
		stm = @db.prepare "SELECT Valeur FROM CoupleValParam WHERE Parametre = \"#{param}\""
    	rs = stm.execute 
    	rs.each do |row|
        	result = row.join "\s"
    	end 
    	return result
	end

end 

