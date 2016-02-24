# encoding: UTF-8

##
# Auteur HOUSSAM KHALID AL-KASSOUM
# Projet L3 SPI : picross
# Version 0.1 : Date : 24/02/2016
#

require 'test/unit'
load './class/profile.class.rb'

class TestGrille < Test::Unit::TestCase

	#test creation d'un profile 
	def test_creation()
		profile = Profile.creer("codeKiller","AL-KASSOUM" ,"Houssam",227)
		assert_equal("codeKiller", profile.pseudo)
		assert_equal("AL-KASSOUM", profile.nom)
		assert_equal("Houssam", profile.prenom)
		assert_equal(227, profile.id)
		assert_equal(0, profile.argent)
	end

	#test modification du profile
	def test_modification()

			profile = Profile.creer("codeKiller","AL-KASSOUM" ,"Houssam",227)
			profile.pseudo("rafiki")
			assert_equal("rafiki",profile.pseudo)
			profile.argent(2000)
			assert_equal(2000,profile.argent)

	end

end
