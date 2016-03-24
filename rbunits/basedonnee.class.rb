#!/usr/bin/ruby

# Test unitaire Basedonnee.rb
# Auteur : Grude Victorien


require 'test/unit'
load './class/basedonnee.class.rb'

#Vos tests dans ce fichier
#https://github.com/olbrich/ruby-units


class Testbasedonnee < Test::Unit::TestCase

	def test_bdd_creation
		kBase = Basedonnee.creer('test.db')
		assert_equal(True, File.exist?('test.db'))
	end

	def test_bdd_key

		i = 0

		kBase = Basedonnee.creer('test.db')

		5.times {
			assert(kBase.addParam('test'+i.to_s, 3))
			assert_equal(3, kBase.getParam('test'+i.to_s))
			i += 1
		}

	end

end
