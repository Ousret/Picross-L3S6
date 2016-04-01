require 'test/unit'
require 'faker'
require File.expand_path(File.dirname(__FILE__)) + '/test_helper.rb'
load './class/crypt.class.rb'

class MyTest < Test::Unit::TestCase

	def test_new_cryptOneParameter
		20.times{
			Crypt.creer(Faker::Hipster.sentence(15))
		}

	end
	def test_new_cryptTwoParameters
		20.times{
			Crypt.creer(Faker::Hipster.sentence(15),Faker::Hipster.sentence(15))
		}

	end
	def test_new_cryptThreeParameters
		20.times{
			Crypt.creer(Faker::Hipster.sentence(15),Faker::Hipster.sentence(15),Faker::Hipster.sentence(15))
		}

	end
	def test_new_cryptAes128OneParameters
		20.times{
			Crypt.creerAes128(Faker::Hipster.sentence(15))
		}

	end
	def test_new_cryptAes128TwoParameters
		20.times{
			Crypt.creerAes128(Faker::Hipster.sentence(15),Faker::Hipster.sentence(15))
		}
	end


	def test_crypt_decrypt
		15.times{
			kCrypt = Crypt.creer(Faker::Hipster.sentence(15))
			testString=Faker::Hipster.sentence(15)
			assert_equal(testString, kCrypt.decrypt(kCrypt.encrypt(testString)) )
		}
	end


	def test_encrypt
		kCrypt = Crypt.creer(Faker::Hipster.sentence(15))
		nbIterations=2
		nbIterations.times{
			kCrypt.encrypt(Faker::Hipster.sentence(15))
		}
		assert_equal(kCrypt.nbOfEncrypt, nbIterations )
	end


	def test_decrypt

		testCipherDecrypt = Crypt.creer(Faker::Hipster.sentence(15))
		nbIterations=2

		nbIterations.times{
			testCipherDecrypt.decrypt(testCipherDecrypt.encrypt(Faker::Hipster.sentence(15)))
		}
		assert_equal(testCipherDecrypt.nbOfDecrypt, nbIterations )

	end

end
