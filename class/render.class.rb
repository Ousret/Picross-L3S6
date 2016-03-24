# Classe interpreteur objet fenêtre vers rendu GL(UT)
# Necessite OpenAL, OpenGL, FreeType, LibSnd
# (c) 2016 - Groupe B - Picross L3 SPI Informatique
# Université du Maine

require 'ray'

module Rendu
  class Scene < Ray::Scene

    scene_name :primary

    def newText(unChampText)
      text unChampText.contenu, :at => [unChampText.posx, unChampText.posy], :size => unChampText.police
    end

  end

  class Jeu < Ray::Game

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
end
