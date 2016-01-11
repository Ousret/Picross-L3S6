require 'test/unit'
load 'class/l3s6.class.rb'

#Vos tests dans ce fichier
#https://github.com/olbrich/ruby-units


class MyTest < Test::Unit::TestCase

	def test_alpha
		kDef = Def.new(199)
		assert_equal(199, kDef.val)
	end

end

#puts "Début des tests pour class L3s6.class.rb .."

