#!/usr/bin/ruby

# Test unitaire Basedonnee.rb
# Auteur : Grude Victorien, TAHRI Ahmed


require 'test/unit'
load './class/registre.class.rb'

#Vos tests dans ce fichier
#https://github.com/olbrich/ruby-units

class Testbasedonnee < Test::Unit::TestCase

	def test_bdd_creation
		kBase = Registre.creer('test.db')
		assert_equal(true, File.exist?('test.db'))
	end

	def test_bdd_key

		i = 0

		kBase = Registre.creer('test.db')

		assert(kBase.addParam('nbJours', 81))
		assert_equal(81, kBase.getValue('nbJours'))

		assert(kBase.addParam('typeCarte', 'VISA'))
		assert_equal('VISA', kBase.getValue('typeCarte'))

		assert(kBase.addParam('qteArgent', 1872.21))
		assert_equal(1872.21, kBase.getValue('qteArgent'))

	end

end
