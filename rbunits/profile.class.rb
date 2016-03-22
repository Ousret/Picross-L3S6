# encoding: UTF-8

##
# Auteur HOUSSAM KHALID ALKASSOUM
# Projet L3 SPI : picross
# Version 0.1 : Date : 24/02/2016
#

#==========================================================================================================
#si la base de donnée existe il faut la recreer pour les test
#if File.exist?('picross.db')
     #File.delete('picross.db')
#end
#if File.exist?('picross.log')
      #File.delete('picross.log')
#end
#==========================================================================================================

require 'test/unit'
load './class/profile.class.rb'

class TestProfile < Test::Unit::TestCase


   



	#test creation d'un profile 
	def test_creation()
		profile = Profile.creer("codeKiller","AL-KASSOUM" ,"Houssam")
		assert_equal("codeKiller", profile.pseudo)
		assert_equal("AL-KASSOUM", profile.nom)
		assert_equal("Houssam", profile.prenom)
		assert_equal(0, profile.argent)
	end

	#test modification et mise a jour dans la base d'un profile
	def test_modification()
            #creation du profile et sauvegarde
			profile = Profile.creer("codeKiller2","AL-KASSOUM2" ,"Houssam2")
            #profile.sauver

            #modification du profile et mise a jour dans la BDA 
			profile.argent=2000
            #profile.mettreAJour

            #on verifi si les modifications on bien été prise en compte dans la BDA
           # profile2 = Profile.find_by_pseudo("codeKiller2")
			#assert_equal(2000,profile2.argent)

	end

    #test sauvegarde/chargement
    def test_sauvegarde()
			profile = Profile.creer("codeKiller3","AL-KASSOUM3" ,"Houssam3")
			#profile.sauver
           # profile2 = Profile.charger('codeKiller3')
           # assert_equal(profile.eql(profile2),true)

	end

    #test creation puis sauvegarde de deux profile avec le meme pseudo
    def test_sauvegarde2()
			profile = Profile.creer("codeKiller4","AL-KASSOUM4" ,"Houssam4")
            profile2 = Profile.creer("codeKiller4","AL-KASSOUM4" ,"Houssam4")
			#profile.sauver
           # exception = assert_raise(ActiveRecord::RecordNotUnique){profile2.sauver}
           # assert_equal("pseudo est deja utiliser", exception.message)

	end
    

end
