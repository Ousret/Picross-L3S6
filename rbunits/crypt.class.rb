require 'test/unit'
load 'class/crypt.class.rb'

#Vos tests dans ce fichier
#https://github.com/olbrich/ruby-units


class MyTest < Test::Unit::TestCase

	def test_new_crypt
		kCrypt = Crypt.new("multipass")
		assert_equal("Newborn", kCrypt.state)
	end

	def test_crypt_decrypt
		kCrypt = Crypt.new("multipass")
		assert_equal("bla", kCrypt.decrypt(kCrypt.encrypt("bla")) )
	end
end

#puts "Début des tests pour class crypt.class.rb .."

