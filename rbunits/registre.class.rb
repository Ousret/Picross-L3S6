#!/usr/bin/ruby

# Tests unitaire Registre
# Auteur : Grude Victorien, TAHRI Ahmed

require 'test/unit'
require File.expand_path(File.dirname(__FILE__)) + '/test_helper.rb'
load './class/crypt.class.rb'
load './class/registre.class.rb'

# Tests unitaire sur la classe Registre
# Création, modification et suppression
class TestRegistre < Test::Unit::TestCase

	self.test_order = :defined

	# Le registre SQLite3+OpenSSL
	def setup
		@kBase = Registre.creer('database-unit.db')
	end

	#Vérifie que le fichier SQLite est bel et bien existant
	# * *Returns* :
	# - bool
	def test_existe?
		assert_equal(true, File.exist?('database-unit.db'))
	end

	#Vérifie la création de paramètre dans le registre
	# * *Returns* :
	# - bool
	def test_creation
		assert(@kBase.addParam('nbJours', '81'))
		assert_equal('81', @kBase.getValue('nbJours'))

		assert(@kBase.addParam('typeCarte', 'VISA'))
		assert_equal('VISA', @kBase.getValue('typeCarte'))

		assert(@kBase.addParam('qteArgent', '1872.21'))
		assert_equal('1872.21', @kBase.getValue('qteArgent'))
	end

	#Vérifie la modification de paramètre dans le registre
	# * *Returns* :
	# - bool
	def test_changement
		assert(@kBase.updateParam('nbJours', '99'))
		assert_equal('99', @kBase.getValue('nbJours'))

		assert(@kBase.updateParam('typeCarte', 'Inconnue'))
		assert_equal('Inconnue', @kBase.getValue('typeCarte'))

		assert(@kBase.updateParam('qteArgent', '12.1'))
		assert_equal('12.1', @kBase.getValue('qteArgent'))
	end

	#Vérifie la suppression de paramètre dans le registre
	# * *Returns* :
	# - bool
	def test_nettoyage
		@kBase.deleteParam('nbJours')
		assert_equal(nil, @kBase.getValue('nbJours'))

		@kBase.deleteParam('typeCarte')
		assert_equal(nil, @kBase.getValue('typeCarte'))

		@kBase.deleteParam('qteArgent')
		assert_equal(nil, @kBase.getValue('qteArgent'))
	end

end
