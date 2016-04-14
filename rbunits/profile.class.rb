# encoding: UTF-8

##
# Auteur HOUSSAM KHALID ALKASSOUM
# Projet L3 SPI : picross
# Version 0.1 : Date : 24/02/2016
#

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
	
end
