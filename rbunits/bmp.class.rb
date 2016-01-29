require 'test/unit'
load 'class/bmp.class.rb'

class MyTest < Test::Unit::TestCase

	def test_bmp_new_bmp_1
		2.times{
			bmp = BMP::Reader.new("ressources/images/bmp.bmp")		
		}
	end

	def test_bmp_new_bmp_2
		2.times{
			bmp = BMP::Reader.new("ressources/images/bmp2.bmp")		
		}
	end

	def test_bmp_new_bmp_3
		2.times{
			bmp = BMP::Reader.new("ressources/images/bmp3.bmp")		
		}
	end

	def test_bmp_matrice_1
		bmp = BMP::Reader.new("ressources/images/bmp.bmp")
		2.times{
			p bmp.width  #=> 2
			p bmp.height #=> 2

			0.upto(bmp.width-1) do |i|
				0.upto(bmp.height-1) do |j|
					#assert_equal(bmp[i,j]) tester si =1 ou 0
				end
			end
		}
	end
end
	

	
		
