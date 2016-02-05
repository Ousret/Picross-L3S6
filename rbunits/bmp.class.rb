require 'test/unit'
load 'class/bmp.class.rb'

class MyTest < Test::Unit::TestCase

	def test_bmp_new_bmp_1
#test si l'initialisation avec l'image bmp.bmp fonctionnne ou non
		2.times{
			bmp = BMP::Reader.new("ressources/images/bmp.bmp")		
		}
	end

	def test_bmp_new_bmp_2
#test si l'initialisation avec l'image bmp2.bmp fonctionnne ou non
		2.times{
			bmp = BMP::Reader.new("ressources/images/bmp2.bmp")		
		}
	end

	def test_bmp_new_bmp_3
#test si l'initialisation avec l'image bmp3.bmp fonctionnne ou non
		2.times{
			bmp = BMP::Reader.new("ressources/images/bmp3.bmp")		
		}
	end

	def test_bmp_matrice_1
	#test si la matrice récupérée est bien binaire
	#test si les dimensions sont des entiers supérieur à 0
		bmp = BMP::Reader.new("ressources/images/bmp.bmp")
		2.times{
			#premier test : vérifie les dimensions
			flag = bmp.width>0?1:0
			assert_equal(flag,1)
			flag = bmp.height>0?1:0
			assert_equal(flag,1)
			#test chaque pixel : chaque pixel doit être égal à 0 ou 1
			0.upto(bmp.width-1) do |i|
				0.upto(bmp.height-1) do |j|
					flag = (bmp[i,j]==1||bmp[i,j]==0) ? 1 : 0
					assert_equal(flag,1)
				end
			end
		}
	end
end
	

	
		
