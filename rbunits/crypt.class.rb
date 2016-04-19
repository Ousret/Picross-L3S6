require 'test/unit'
require 'faker'
require File.expand_path(File.dirname(__FILE__)) + '/test_helper.rb'
load './class/crypt.class.rb'

class MyTest < Test::Unit::TestCase

	def test_new_cryptOneParameter
		10.times{
			Crypt.creer(Faker::Hipster.sentence(15))
		}

	end


	def test_new_cryptTwoParameters
		10.times{
			Crypt.creer(Faker::Hipster.sentence(15),Faker::Hipster.sentence(15))
		}

	end


	def test_new_cryptThreeParameters
		10.times{
			Crypt.creer(Faker::Hipster.sentence(15),Faker::Hipster.sentence(15),Faker::Hipster.sentence(15))
		}

	end


	def test_new_cryptAes128OneParameter
		10.times{
			Crypt.creerAes256GCM(Faker::Hipster.sentence(15))
		}

	end


	def test_new_cryptAes128TwoParameters
		10.times{
			Crypt.creerAes256GCM(Faker::Hipster.sentence(15),Faker::Hipster.sentence(15))
		}
	end


	def test_encrypt_normalCrypt_creer1param
		kCrypt = Crypt.creer(Faker::Hipster.sentence(15))
		nbIterations=5
		nbIterations.times{
			kCrypt.encrypt(Faker::Hipster.sentence(10))
		}
		assert_equal(kCrypt.nbOfEncrypt, nbIterations )
	end

	def test_encrypt_normalCrypt_creer2params
		kCrypt = Crypt.creer(Faker::Hipster.sentence(15),'aes-256-gcm')
		nbIterations=5
		nbIterations.times{
			kCrypt.encrypt(Faker::Hipster.sentence(10))
		}
		assert_equal(kCrypt.nbOfEncrypt, nbIterations )
	end

	def test_encrypt_normalCrypt_creer3params
		kCrypt = Crypt.creer(Faker::Hipster.sentence(15),'aes-256-gcm',Faker::Hipster.sentence(15))
		nbIterations=5
		nbIterations.times{
			kCrypt.encrypt(Faker::Hipster.sentence(10))
		}
		assert_equal(kCrypt.nbOfEncrypt, nbIterations )
	end

	def test_encrypt_aes256gcmCrypt_creer1params
		kCrypt = Crypt.creerAes256GCM(Faker::Hipster.sentence(15))
		nbIterations=5
		nbIterations.times{
			kCrypt.encrypt(Faker::Hipster.sentence(10))
		}
		assert_equal(kCrypt.nbOfEncrypt, nbIterations )
	end

	def test_encrypt_aes256gcmCrypt_creer2params
		kCrypt = Crypt.creerAes256GCM(Faker::Hipster.sentence(15),Faker::Hipster.sentence(15))
		nbIterations=5
		nbIterations.times{
			kCrypt.encrypt(Faker::Hipster.sentence(10))
		}
		assert_equal(kCrypt.nbOfEncrypt, nbIterations )
	end

	def test_crypt_decrypt
		10.times{
			kCrypt = Crypt.creer(Faker::Hipster.sentence(15))
			testString=Faker::Hipster.sentence(10)
			assert_equal(testString, kCrypt.decrypt(kCrypt.encrypt(testString)) )
		}
	end

	def test_decrypt

		testCipherDecrypt = Crypt.creer(Faker::Hipster.sentence(15))
		nbIterations=5

		nbIterations.times{
			testCipherDecrypt.decrypt(testCipherDecrypt.encrypt(Faker::Hipster.sentence(10)))
		}
		assert_equal(testCipherDecrypt.nbOfDecrypt, nbIterations )

	end



end
