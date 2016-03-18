# Classe interpreteur objet fenêtre vers rendu GL(UT)
# Necessite OpenAL, OpenGL, FreeType, LibSnd
# (c) 2016 - Groupe B - Picross L3 SPI Informatique
# Université du Maine

require 'ray'

class Rendu

  # La fenêtre à rendre
  attr_writer :contexte

  def initialize(unContexteInitial)
    @contexte = unContexteInitial
  end

  # Effectue le rendu en boucle si un élement bloquant si trouve (saisie & boutton)
  # Retourne l'objet selectionné
  def rendu()
    @contexte.listeComposant.each_char { |element|  }
  end

end
