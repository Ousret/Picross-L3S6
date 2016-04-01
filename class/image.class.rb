#
# Author::    Ousret https://github.com/Ousret
# License::   MIT Licence
#
# https://github.com/Ousret/Picross-L3S6
#
#*Classe représentant une Image

class Image < ObjetGUI

  attr_accessor :path

  def initialize(uneDesignation, unCheminRelatif, unePositionX, unePositionY, unePositionZ)
    super(uneDesignation, unePositionX, unePositionY, unePositionZ, -1, -1)
    @path = unCheminRelatif
  end

end
