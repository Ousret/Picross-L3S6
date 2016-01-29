# coding: binary

class BMP
	class Reader
#variables
		PIXEL_ARRAY_OFFSET =54
		BITS_PER_PIXEL     = 24 #défini le nombre de bit pour un pixel
		DIB_HEADER_SIZE    = 40 #défini la taille du header

		def initialize(bmp_filename)
#constructeur
#ouvre une image, lit son header et défini la matrice binaire
#fait trois fonctions pour traiter le header, les exceptions et les pixels
			File.open(bmp_filename, "rb") do |file|
				read_bmp_header(file)
				read_dib_header(file)
				read_pixels(file)
			end
	    end

		def [](x,y)
#fonction qui permet de ressortir le boolean correspondant à un pixel
#arguments : deux entiers comme des coordonnées
#retourne le boolean qui défini un pixel : le pixel est défini en #fonction d'un x et d'un y
#convertie de l'hexa en binaire
			@pixels[y][x]=="ffffff"?0:1
		end
#getters
#permet de récupérer les dimensions de l'image et donc de la matrice
		attr_reader :width, :height

		def read_pixels(file)
#fonction qui défini la matrice
#initialisation de la matrice
			@pixels = Array.new(@height) { Array.new(@width) }
#parcours le tableau ligne par ligne
#colonnes par colonne pour traduire l'image en binaire
			(@height-1).downto(0) do |y|
				0.upto(@width - 1) do |x|
					@pixels[y][x] = file.read(3).unpack("H6").first
				end
				advance_to_next_row(file)
			end
		end

		def advance_to_next_row(file)
#fonction qui défini les colonnes d'un fichier
#utiliser plus haut
			padding_bytes = @width % 4
			return if padding_bytes == 0
			file.pos += padding_bytes
		end
	
		def read_bmp_header(file)
#fonction qui vérifie le header du file : 
#permet de vérifier si le header correspond à notre traitement

			header = file.read(14)
			magic_number, file_size, reserved1,
			reserved2, array_location = header.unpack("A2Vv2V")
    	  
			fail "Not a bitmap file!" unless magic_number == "BM"
#vérifie la taille du fichier	
			unless file.size == file_size
				fail "Corrupted bitmap: File size is not as expected" 
			end
#vérifie l'allocation pour le tableau	
			unless array_location == PIXEL_ARRAY_OFFSET
				fail "Unsupported bitmap: pixel array does not start where expected"
			end
		end
	
		def read_dib_header(file)
#fonction qui effectue des tests pour les exceptions :
#test si l'url est bonne
#test si l'image est convenable :
#	l'image doit être codée avec du 24bit par pixel
			header = file.read(40)
	
			header_size, width, height, planes, bits_per_pixel, 
			compression_method, image_size, hres, 
			vres, n_colors, i_colors = header.unpack("Vl<2v2V2l<2V2") 
#test si la taille du header convient	
			unless header_size == DIB_HEADER_SIZE
				fail "Corrupted bitmap: DIB header does not match expected size"
			end
#vérifie que l'image n'est pas endommagée
			unless planes == 1
				fail "Corrupted bitmap: Expected 1 plane, got #{planes}"
			end
#vérifie le nombre de bits par pixel
			unless bits_per_pixel == BITS_PER_PIXEL
				fail "#{bits_per_pixel} bits per pixel bitmaps are not supported"
			end
#vérifie si l'image n'est pas compressée
			unless compression_method == 0
				fail "Bitmap compression not supported"
			end
#vérifie quelque chose
			unless image_size + PIXEL_ARRAY_OFFSET == file.size
				fail "Corrupted bitmap: pixel array size isn't as expected"
			end
#initialise les dimensions de la matrice
			@width, @height = width, height
		end
	end
end
#cette classe s'instancie de la façon suivante : BMP::Reader.new()
#une fois l'instance faite, on peut récupérer chaque bit grace au tableau
#on peut aussi récupérer les dimensions
