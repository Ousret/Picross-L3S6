#!/usr/bin/ruby

# Test unitaire Basedonnee.rb
# Auteur : Grude Victorien


require 'test/unit'
load './class/basedonnee.class.rb'

#Vos tests dans ce fichier
#https://github.com/olbrich/ruby-units


class Testbasedonnee < Test::Unit::TestCase

	def test_bdd_creation
		20.times{
			kBase = Basedonnee.creer('test.db')
		}
	end

	def test_bdd_blob
		20.times{
			kBase = Basedonnee.creer('test.db')
			assert(kBase.ajouteParamBlob('test1','Blabla'))
			assert_equal('Blabla',kBase.lireParamBlob('test1'))
		}
	end

	def test_bdd_int
		20.times{
			kBase = Basedonnee.creer('test.db')
			assert(kBase.ajouteParamInt('test2',5))
			assert_equal(5,kBase.lireParamInt('test2'))
		}
	end

	def test_bdd_bool
		20.times{
			kBase = Basedonnee.creer('test.db')
			assert(kBase.ajouteParamBool('test3',true))
			assert_equal(true,kBase.lireParamBool('test3'))
		}
	end

	def test_bdd_float
		20.times{
			kBase = Basedonnee.creer('test.db')
			assert(kBase.ajouteParamFloat('test4',3.7))
			assert_equal(3.7,kBase.lireParamFloat('test4'))
		}
	end

	def test_bdd_string
		20.times{
			kBase = Basedonnee.creer('test.db')
			assert(kBase.ajouteParamString('test5','efgh'))
			assert_equal('efgh',kBase.lireParamString('test5'))
		}
	end

end
