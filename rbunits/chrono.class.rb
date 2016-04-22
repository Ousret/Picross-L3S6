# encoding: UTF-8

##
# Auteur HOUSSAM KHALID ALKASSOUM
# Projet L3 SPI : picross
# Version 0.1 : Date : 24/02/2016
#

require 'test/unit'
load './class/chrono.class.rb'

class TestChrono < Test::Unit::TestCase

	#test creation d'une config de jeu
	def test_chrono()
        chrono = Chrono.creer()
        chrono.demarer()
        sleep 60
        chrono.arreter()
		assert_equal(chrono.nbMinute, 1)
        assert_equal(chrono.nbHeure, 0)
        assert_equal(chrono.nbSeconde, 0)
	end

end
