require 'test/unit'
require 'faker'
require File.expand_path(File.dirname(__FILE__)) + '/test_helper.rb'
load './class/crypt.class.rb'

class MyTest < Test::Unit::TestCase

	def setup
		@kCrypt = Crypt.creer(Faker::Hipster.sentence(15))
	end

end
