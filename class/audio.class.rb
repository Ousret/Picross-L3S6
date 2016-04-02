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

  def initialize(uneDesignation, unCheminRelatif, lectureInfinie, uneAttenuation, uneFrequencePitch, unePositionX, unePositionY, unePositionZ) # :nodoc:
    super(uneDesignation, unePositionX, unePositionY, unePositionZ, -1, -1)
    @path, @infinite, @pitch = unCheminRelatif, lectureInfinie, uneFrequencePitch
  end

  # Représentation d'une piste audio
  # * *Arguments*    :
  #   - +uneDesignation+ -> Designation de la piste audio
  #   - +unCheminRelatif+ -> Chemin relatif vers le fichier audio
  #   - +lectureInfinie+ -> Lecture en boucle
  #   - +uneAttenuation+ -> Coeff d'attenuation du son
  #   - +uneFrequencePitch+ -> Un indice de vitesse de lecture (0..1)
  #   - +unePositionX+ -> Position du son sur l'axe X du monde
  #   - +unePositionY+ -> Position du son sur l'axe Y du monde
  #   - +unePositionZ+ -> Position du son sur l'axe Z du monde
  # * *Returns*
  #   - Audio
  def Audio.creer(uneDesignation, unCheminRelatif, lectureInfinie, uneAttenuation, uneFrequencePitch, unePositionX, unePositionY, unePositionZ)
    new(uneDesignation, unCheminRelatif, lectureInfinie, uneAttenuation, uneFrequencePitch, unePositionX, unePositionY, unePositionZ)
  end

end
