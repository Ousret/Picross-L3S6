require 'test/unit'
load './class/crypt.class.rb'

class MyTest < Test::Unit::TestCase

	def test_new_crypt
		2.times{
			kCrypt = Crypt.creer("Faker::Hipster.sentence(15)")
		}
		
	end


	def test_crypt_decrypt
		kCrypt = Crypt.creer("Faker::Hipster.sentence(15)")
		testString="Faker::Hipster.sentence(15)"
		assert_equal(testString, kCrypt.decrypt(kCrypt.encrypt(testString)) )
	end


	def test_encrypt
		kCrypt = Crypt.creer("Faker::Hipster.sentence(15)")
		nbIterations=2
		nbIterations.times{
			kCrypt.encrypt("Faker::Hipster.sentence(15)")
		}
		assert_equal(kCrypt.nbOfEncrypt, nbIterations )
	end


	def test_decrypt
		kCrypt = Crypt.creer("Faker::Hipster.sentence(15)")
		nbIterations=2
		nbIterations.times{
			kCrypt.decrypt("Faker::Hipster.sentence(15)")
		}
		#assert_equal(kCrypt.nbOfDecrypt, nbIterations )
	end

end