#!/usr/bin/ruby

# Test unitaire Basedonnee.rb
# Auteur : Grude Victorien
# Version : 1.0
# Date : 22/01/16

require 'test/unit'
load 'class/basedonnee.class.rb'

#Vos tests dans ce fichier
#https://github.com/olbrich/ruby-units


class Testbasedonnee < Test::Unit::TestCase

	def Test_base_de_donnee_1
		kBase = Basedonnee.Creer('test.rb')
		kBase.ajouteParam('test1','adcb')
		assert_equal('abcd',kBase.lireParam('test2'))
	end

end

