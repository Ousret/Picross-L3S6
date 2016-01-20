require 'test/unit'
load 'class/lecteurSon.class.rb'

#Vos tests dans ce fichier
#https://github.com/olbrich/ruby-units


class MyTest < Test::Unit::TestCase

	def test_new_LecteurSon
		kLecteur = LecteurSon.new()
		assert_equal("op", kLecteur.state)
	end

end