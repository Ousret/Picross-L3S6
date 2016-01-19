require 'test/unit'
load 'class/LecteurSon.class.rb'

#Vos tests dans ce fichier
#https://github.com/olbrich/ruby-units


class MyTest < Test::Unit::TestCase

	def test_alpha
		kDef = LecteurSon.new()
		assert_equal("op", kDef.state)
	end

end