#
# Author::    Ousret https://github.com/Ousret
# License::   MIT Licence
#
# https://github.com/Ousret/Picross-L3S6
#
#*Classe représentant un Son (3D)

class Audio < ObjetGUI

  attr_accessor :path, :infinite, :pitch
  private_class_method :new

  def initialize(uneDesignation, unCheminRelatif, lectureInfinie, uneAttenuation, uneFrequencePitch, unePositionX, unePositionY, unePositionZ)
    super(uneDesignation, unePositionX, unePositionY, unePositionZ, -1, -1)
    @path = unCheminRelatif
  end

  def Audio.creer(uneDesignation, unCheminRelatif, unePositionX, unePositionY, unePositionZ)
    new(uneDesignation, unCheminRelatif, unePositionX, unePositionY, unePositionZ)
  end

end
