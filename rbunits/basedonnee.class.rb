#!/usr/bin/ruby

# Test unitaire Basedonnee.rb
# Auteur : Grude Victorien


require 'test/unit'
load './class/basedonnee.class.rb'

#Vos tests dans ce fichier
#https://github.com/olbrich/ruby-units


class Testbasedonnee < Test::Unit::TestCase

	def test_bdd_creation
		5.times{
			kBase = Basedonnee.creer('test.db')
		}
	end

	def test_bdd_blob
		i = 0
		kBase = Basedonnee.creer('test.db')
		5.times {
			assert(kBase.ajouteParamBlob('test'+i.to_s,3))
			assert_equal(3,kBase.lireParamBlob('test'+i.to_s))
			i += 1
		}
	end

	def test_bdd_int
		i = 0
		kBase = Basedonnee.creer('test.db')
		5.times{
			assert(kBase.ajouteParamInt('test'+i.to_s,5))
			assert_equal(5,kBase.lireParamInt('test'+i.to_s))
			i +=1
		}
	end

	def test_bdd_float
		i = 0
		kBase = Basedonnee.creer('test.db')
		5.times{
			assert(kBase.ajouteParamFloat('test'+i.to_s,3.7))
			assert_equal(3.7,kBase.lireParamFloat('test'+i.to_s))
			i += 1
		}
	end

	def test_bdd_string
		i = 0
		kBase = Basedonnee.creer('test.db')
		5.times{
			assert(kBase.ajouteParamString('test'+i.to_s,'efgh'))
			assert_equal('efgh',kBase.lireParamString('test'+i.to_s))
			i += 1
		}
	end

	def test_bdd_meme_valeur_string
		i = 0
		kBase = Basedonnee.creer('test.db')
		5.times{
			assert(kBase.ajouteParamString('test','efgh'+i.to_s))
			assert_equal('efgh'+i.to_s,kBase.lireParamString('test'))
			i += 1
		}
	end

end
