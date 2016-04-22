#==========================================================================================================
#si la base de donnée existe il faut la recreer pour les test
if File.exist?('picross.db')
     File.delete('picross.db')
end
if File.exist?('picross.log')
      File.delete('picross.log')
end
#==========================================================================================================
load './class/grille.class.rb'
load './class/profile.class.rb'
load './class/partie.class.rb'

require_relative 'connectSqlite3.rb'

class TestBD < Test::Unit::TestCase

    #test modification et mise a jour dans la base d'un profile
	def test_modification()
            #creation du profile et sauvegarde
			profile = Profile.creer("codeKiller2","AL-KASSOUM2" ,"Houssam2")
            profile.sauver

            #modification du profile et mise a jour dans la BDA
			profile.argent=2000
            profile.mettreAJour

            #on verifi si les modifications on bien été prise en compte dans la BDA
            profile2 = Profile.find_by_pseudo("codeKiller2")
			assert_equal(2000,profile2.argent)

	end

    #test sauvegarde/chargement
    def test_sauvegarde()
			profile = Profile.creer("codeKiller3","AL-KASSOUM3" ,"Houssam3")
			profile.sauver
            profile2 = Profile.charger('codeKiller3')
            assert_equal(profile.eql(profile2),true)

	end

    #test creation puis sauvegarde de deux profile avec le meme pseudo
    def test_sauvegarde2()
			profile = Profile.creer("codeKiller4","AL-KASSOUM4" ,"Houssam4")
            profile2 = Profile.creer("codeKiller4","AL-KASSOUM4" ,"Houssam4")
			profile.sauver
            exception = assert_raise(ActiveRecord::RecordNotUnique){profile2.sauver}
            assert_equal("pseudo est deja utiliser", exception.message)

	end

    #test creation d'une partie
    def test_creationPartie()
        matrice =[[0,0,1,0,1],[1,1,0,1,0],[0,0,1,0,0],[1,1,0,1,0],[0,1,1,1,1]]
        profile = Profile.creer("codeKiller","AL-KASSOUM" ,"Houssam")
        grille  = Grille.grille(matrice)
        config = Partie.configurer(grille.id,profile.id)
        assert_equal(profile.id, config.profileID)
        assert_equal(grille.id, config.grilleID)
    end

    #test sauvegarde et chargement d'une partie
    #test creation d'une partie
    def test_sauvegardePartie()
        matrice =[[0,0,1,0,1],[1,1,0,1,0],[0,0,1,0,0],[1,1,0,1,0],[0,1,1,1,1]]
        profile = Profile.creer("codeKiller","AL-KASSOUM" ,"Houssam")
        grille  = Grille.grille(matrice)
        profile.sauver
        grille.sauver
        partie = Partie.configurer(grille.id,profile.id)
        assert_equal(profile.id, partie.profileID)
        assert_equal(grille.id, partie.grilleID)
        partie.sauver

    end

     #test sauvegarde et chargement d'une partie
    #test creation d'une partie
    def test_sauvegardeModificationGrille()
        matrice =[[0,0,1,0,1],[1,1,0,1,0],[0,0,1,0,0],[1,1,0,1,0],[0,1,1,1,1]]
        grille = Grille.grille(matrice)
        grille.sauver()
        grille2 = Grille.charger(1)
        assert_equal(grille, grille2)

        grille2.noirsirCase(2,1)
        grille2.mettreAJour()
        grille3 = Grille.charger(1)
        assert_equal(grille2, grille3)
    end

end