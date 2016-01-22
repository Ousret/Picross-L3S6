require 'test/unit'
load 'class/crypt.class.rb'

#Vos tests dans ce fichier
#https://github.com/olbrich/ruby-units


class MyTest < Test::Unit::TestCase

	def test_new_crypt
		2.times{
			kCrypt = Crypt.creerEncodeurDecodeur("multipass")
		}
		
	end

	def test_crypt_decrypt
		kCrypt = Crypt.creerEncodeurDecodeur("multipass")
		assert_equal("bla", kCrypt.decrypt(kCrypt.encrypt("bla")) )
	end
	def test_encrypt
		kCrypt = Crypt.creerEncodeurDecodeur("multipass")
		nbIterations=2
		nbIterations.times{
			kCrypt.encrypt("sehr")
			#assert_equal(kCrypt.nbOfEncrypt, nbIterations )
		}
	end


	def test_decrypt
		kCrypt = Crypt.creerEncodeurDecodeur("multipass")
		nbIterations=2
		nbIterations.times{
			kCrypt.decrypt("deh")
			#assert_equal(kCrypt.nbOfDecrypt, nbIterations )
		}
	end

end

#puts "Début des tests pour class crypt.class.rb .."

