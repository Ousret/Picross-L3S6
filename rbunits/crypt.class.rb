require 'test/unit'
load 'class/crypt.class.rb'

#Vos tests dans ce fichier
#https://github.com/olbrich/ruby-units


class MyTest < Test::Unit::TestCase

	def test_alpha
		kCrypt = Crypt.new()
		assert_equal("operationnel", kCrypt.state)
	end

end

#puts "Début des tests pour class crypt.class.rb .."

