require 'test/unit'
load 'class/bmp.class.rb'


class MyTest < Test::Unit::TestCase

	def test_bmp_new_bmp_1
	#test si l'initialisation avec l'image bmp.bmp fonctionnne ou non
		2.times{
			bmp = BMP::Reader.creer("ressources/images/bmp.bmp")		
		}
	end

	def test_bmp_new_bmp_2
	#test si l'initialisation avec l'image bmp2.bmp fonctionnne ou non
		2.times{
			bmp = BMP::Reader.creer("ressources/images/bmp2.bmp")		
		}
	end
	def test_bmp_new_bmp_3
	#test si l'initialisation avec l'image bmp3.bmp fonctionnne ou non
		2.times{
			bmp = BMP::Reader.creer("ressources/images/bmp3.bmp")		
		}
	end
def test_bmp_new_bmp_4
	#test si l'initialisation avec l'image bmp4.bmp fonctionnne ou non
		2.times{
			bmp = BMP::Reader.creer("ressources/images/bmp4.bmp")		
		}
	end
	

	def test_bmp_matrice_1
	#test si la matrice récupérée est bien binaire
	#test si les dimensions sont des entiers supérieur à 0
		bmp = BMP::Reader.creer("ressources/images/bmp.bmp")
		2.times{
			#premier test : vérifie les dimensions
			mat=bmp.getMatrice()
			flag = bmp.width>0?1:0
			assert_equal(flag,1)
			flag = bmp.height>0?1:0
			assert_equal(flag,1)
			#test chaque pixel : chaque pixel doit être égal à 0 ou 1
			#p bmp.width,bmp.height			
			0.upto(bmp.width-1) do |i|
				0.upto(bmp.height-1) do |j|
					#p mat[i][j]
					flag = ((mat[i][j]==1||mat[i][j]==0) ? 1 : 0)
					assert_equal(flag,1)
				end
			end
		}
	end

	def test_bmp_vs_bmp
	#test si la matrice récupérée est bien binaire
	#test si les dimensions sont des entiers supérieur à 0
		
		2.times{
			bmp2 = BMP::Reader.creer("ressources/images/bmp.bmp")	
			#p bmp2.height
			#p bmp2.width			
			bmp1 = BMP::Reader.creer("ressources/images/bmp.bmp")
			#p bmp1.height
			#p bmp1.width
			mat1=bmp1.getMatrice()
			mat2=bmp2.getMatrice()		
			assert_equal(bmp1.height,bmp2.height)
			assert_equal(bmp1.width,bmp2.width)
			#test chaque pixel : chaque pixel doit être identique pour deux instance d'une meme image
			0.upto(bmp1.width-1) do |i|
				0.upto(bmp1.height-1) do |j|
					assert_equal(mat1[i][j],mat2[i][j])
				end
			end
		}
	end
end
	

	
		
