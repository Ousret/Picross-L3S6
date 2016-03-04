# Classe interpreteur objet fenêtre vers rendu GL(UT)
# Necessite OpenAL, OpenGL, FreeType, LibSnd
# (c) 2016 - Groupe B - Picross L3 SPI Informatique
# Université du Maine

require 'ray'

class Rendu

  attr_writer :contexte

  def initialize(unContexteInitial)
    @contexte = unContexteInitial
  end

  def rendu()
    @contexte.listeComposant.each_char { |element|  }
  end

end
