require 'test/unit'
require 'faker'
load 'class/crypt.class.rb'

#Vos tests dans ce fichier
#https://github.com/olbrich/ruby-units


class MyTest < Test::Unit::TestCase

	def test_new_crypt
		2.times{
			kCrypt = Crypt.creerEncodeurDecodeur(Faker::Hipster.sentence(15))
		}
		
	end

	def test_crypt_decrypt
		kCrypt = Crypt.creerEncodeurDecodeur(Faker::Hipster.sentence(15))
		testString=Faker::Hipster.sentence(15)
		assert_equal(testString, kCrypt.decrypt(kCrypt.encrypt(testString)) )
	end
	def test_encrypt
		kCrypt = Crypt.creerEncodeurDecodeur(Faker::Hipster.sentence(15))
		nbIterations=2
		nbIterations.times{
			kCrypt.encrypt(Faker::Hipster.sentence(15))
		}
		assert_equal(kCrypt.nbOfEncrypt, nbIterations )
	end


	def test_decrypt
		kCrypt = Crypt.creerEncodeurDecodeur(Faker::Hipster.sentence(15))
		nbIterations=2
		nbIterations.times{
			kCrypt.decrypt(Faker::Hipster.sentence(15))
		}
		assert_equal(kCrypt.nbOfDecrypt, nbIterations )
	end

end

#puts "Début des tests pour class crypt.class.rb .."

