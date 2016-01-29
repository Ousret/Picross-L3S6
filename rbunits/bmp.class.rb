require 'test/unit'
load 'class/BMP.rb'

class MyTest < Test::Unit::TestCase

	def test_bmp_new_bmp_1
		2.times{
			bmp = BMP::Reader.new("./bmp1.bmp")		
		}
	end

	def test_bmp_new_bmp_2
		2.times{
			bmp = BMP::Reader.new("./bmp2.bmp")		
		}
	end

	def test_bmp_new_bmp_3
		2.times{
			bmp = BMP::Reader.new("./bmp3.bmp")		
		}
	end

	def test_bmp_matrice_1
		bmp = BMP::Reader.new("./bmp1.bmp")
		2.times{
			p bmp.width  #=> 2
			p bmp.height #=> 2

			0.upto(bmp.width-1) do |i|
				0.upto(bmp.height-1) do |j|
					assert_equal(bmp[i,j])
				end
			end
		}
	end
end
	

	
		
