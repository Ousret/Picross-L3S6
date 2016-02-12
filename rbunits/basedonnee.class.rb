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
		i = 0
		20.times {
			kBase = Basedonnee.creer('test.db')
			assert(kBase.ajouteParamBlob('test'+i.to_s,3))
			assert_equal(3,kBase.lireParamBlob('test'+i.to_s))
			i += 1
		}
	end

	def test_bdd_int
		i = 0
		20.times{
			kBase = Basedonnee.creer('test.db')
			assert(kBase.ajouteParamInt('test'+i.to_s,5))
			assert_equal(5,kBase.lireParamInt('test'+i.to_s))
			i +=1
		}
	end

	def test_bdd_bool
		i = 0
		20.times{
			kBase = Basedonnee.creer('test.db')
			assert(kBase.ajouteParamBool('test'+i.to_s,true))
			assert_equal(true,kBase.lireParamBool('test'+i.to_s))
			i+=1
		}
	end

	def test_bdd_float
		i = 0
		20.times{
			kBase = Basedonnee.creer('test.db')
			assert(kBase.ajouteParamFloat('test'+i.to_s,3.7))
			assert_equal(3.7,kBase.lireParamFloat('test'+i.to_s))
			i += 1
		}
	end

	def test_bdd_string
		i = 0
		20.times{
			kBase = Basedonnee.creer('test.db')
			assert(kBase.ajouteParamString('test'+i.to_s,'efgh'))
			assert_equal('efgh',kBase.lireParamString('test'+i.to_s))
			i += 1
		}
	end

end
