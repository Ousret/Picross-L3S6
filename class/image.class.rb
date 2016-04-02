#
# Author::    Ousret https://github.com/Ousret
# License::   MIT Licence
#
# https://github.com/Ousret/Picross-L3S6
#
#*Classe représentant une Image
class Image < ObjetGUI

  attr_accessor :path
  private_class_method :new

  def initialize(uneDesignation, unCheminRelatif, unePositionX, unePositionY, unePositionZ) # :nodoc:
    super(uneDesignation, unePositionX, unePositionY, unePositionZ, -1, -1)
    @path = unCheminRelatif
  end

  #Création d'une instance Image
	#   * *Arguments*
	#     - +uneDesignation+ -> Désignation/identificateur du texte
	#     - +unCheminRelatif+ -> Chemin relatif du fichier image (PNG/JPEG/BMP)
	#     - +unePositionX+ -> Position de l'image sur l'axe X
	#     - +unePositionY+ -> Position de l'image sur l'axe Y
	#     - +unePositionZ+ -> Position de l'image sur l'axe Z
	#  * *Returns*
	#    - Image
  def Image.creer(uneDesignation, unCheminRelatif, unePositionX, unePositionY, unePositionZ)
    new(uneDesignation, unCheminRelatif, unePositionX, unePositionY, unePositionZ)
  end

end
