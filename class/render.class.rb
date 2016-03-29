# Classe interpreteur objet fenêtre vers rendu GL(UT)
# Necessite OpenAL, OpenGL, FreeType, LibSnd
# (c) 2016 - Groupe B - Picross L3 SPI Informatique
# Université du Maine

require 'ray'
require 'tmx'

load './class/objetgui.class.rb'
load './class/fenetre.class.rb'
load './class/button.class.rb'
load './class/saisie.class.rb'
load './class/text.class.rb'

class Rendu

  # La fenêtre à rendre
  attr_writer :contexte
  attr_reader :map

  def initialize(unContexteInitial)
    @contexte = unContexteInitial
  end

  # Effectue le rendu en boucle si un élement bloquant si trouve (saisie & boutton)
  # Retourne l'objet selectionné
  def rendu()
    #@contexte.listeComposant.each_char { |element|  }

    Ray.game @contexte.designation do
      register { add_hook :quit, method(:exit!) }

      scene :stdout do

        @contexte.listeComposant.each do |composant|
          puts "Initialisation du composant #{composant.designation}"
          if (composant.instance_of? Text)
            @text = text composant.contenu, :at => [composant.posx, composant.posy], :size => composant.police
          end
        end

        always do
          
        end

        render do |win|
          win.draw @text
        end

      end
      scenes << :stdout
    end
  end

end


# Tests
kWindow = Fenetre.creer("Picross L3-SPI", 0, 0, 0, 800, 600)
#kWindow.ajouterComposant(Button.creer("Partie rapide", 100, 50, 0, 150, 200))
#kWindow.ajouterComposant(Button.creer("Aventure", 200, 50, 0, 150, 200))
kWindow.ajouterComposant(Text.creer("Welcome-Message", "Bienvenue dans le jeu Picross L3-SPI", 12, 400, 50, 0))

kRender = Rendu.new kWindow
kRender.rendu
