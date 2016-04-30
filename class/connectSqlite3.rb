# encoding: UTF-8

##
# Auteur HOUSSAM KHALID ALKASSOUM
# Projet L3 SPI : picross
# Version 0.1 : Date : 24/02/2016
#


#ce fichier contient les information relative a la BDA
#on utilise active record comme interface entre la BD et le programme
#et on utilise sqlite3 comme BD

ActiveRecord::Base.logger = Logger.new(File.open('picross.log', 'w'))

#information relative a la connection a la BD
ActiveRecord::Base.establish_connection(
:adapter => 'sqlite3',
:database => 'picross.db',
:timeout =>5000
)

#definition du schema de la BDA utiliser
ActiveRecord::Schema.define do

    unless ActiveRecord::Base.connection.tables.include? 'grilles'
      #definition de la table des grilles
      create_table :grilles do |table|
        table.column :matriceComparaisonBD, :string, limit: 1000
        table.column :matriceDeJeuBD, :string, limit: 1000
        table.column :indicesHautBD , :string, limit: 1000
        table.column :indicesCoteBD , :string, limit: 1000

        table.column :nbErreurBD, :integer
        table.column :tempBD , :int8
        table.column :scoreBD, :int8

      end
    end

    unless ActiveRecord::Base.connection.tables.include? 'profiles'
      #definition de la table des profiles
      create_table :profiles do |table|
        table.column :pseudo, :string
        table.column :nom,    :string
        table.column :prenom, :string
        table.column :argent, :integer
      end
      #definition des contraintes sur les tables
      add_index :profiles , :pseudo, unique: true
    end

     unless ActiveRecord::Base.connection.tables.include? 'parties'
      #definition de la table des profiles
      create_table :parties do |table|
        table.column :grilleID,  :integer
        table.column :profileID, :integer
      end
    end

end
