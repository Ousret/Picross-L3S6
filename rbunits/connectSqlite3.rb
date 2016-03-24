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

  #definition de la table des profiles
  unless ActiveRecord::Base.connection.tables.include? 'profiles'
      create_table :profiles do |table|
      table.column :pseudo, :string 
      table.column :nom,    :string
      table.column :prenom, :string
      table.column :argent, :integer
    end

    add_index :profiles , :pseudo, unique: true

  end
end
