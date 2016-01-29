#!/usr/bin/ruby

# Test unitaire Basedonnee.rb
# Auteur : Grude Victorien
# Version : 1.1
# Date : 22/01/16

require 'test/unit'
load 'class/basedonnee.class.rb'

#Vos tests dans ce fichier
#https://github.com/olbrich/ruby-units


class Testbasedonnee < Test::Unit::TestCase

	def Test_base_de_donnee_1
		kBase = Basedonnee.Creer('test.rb')

		kBase.ajouteParamBlob('test1','adcb')
		assert_equal('abcd',kBase.lireParamBlob('test1'))

		kBase.ajouteParamInt('test2',3)
		assert_equal(3,kBase.lireParamInt('test2'))

		kBase.ajouteParamBool('test3',True)
		assert_equal(True,kBase.lireParamBool(True))

		kBase.ajouteParamFloat('test4',3.5)
		assert_equal(3.5,kBase.lireParamFloat('test4'))

		kBase.ajouteParamString('test5','efgh')
		assert_equal('efgh',kBase.lireParamString('test5'))
	end

end
