# encoding: UTF-8

##
# Auteur HOUSSAM KHALID ALKASSOUM
# Projet L3 SPI : picross
# Version 0.1 : Date : 24/02/2016
#

require 'test/unit '
require File.expand_path(File.dirname(__FILE__)) + '/test_helper.rb'
load './class/configuration.class.rb'

class TestConfiguration< Test::Unit::TestCase

	#test creation d'une config de jeu
	def test_creation()
        matrice =[[0,0,1,0,1],[1,1,0,1,0],[0,0,1,0,0],[1,1,0,1,0],[0,1,1,1,1]]
        profile = Profile.creer("codeKiller","AL-KASSOUM" ,"Houssam")
        grille  = Grille.grille(matrice)
		config = Configuration.configurer(grille,profile)
		assert_equal(profile, config.profile)
        assert_equal(grille, config.grille)
	end

end
