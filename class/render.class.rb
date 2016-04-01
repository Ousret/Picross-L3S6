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

module Render

  @@contexte = Array.new
  @@vertex = Array.new

  class Scene < Ray::Scene
    include Render
    scene_name :stdout
    def setup
      window.size = [@@contexte.taillex, @@contexte.tailley]

      #Set ressource on screen
      @@contexte.listeComposant.each do |composant|
        puts "Initialisation du composant #{composant.designation}"
        if (composant.instance_of? Text)
          @text = text composant.contenu, :at => [composant.posx, composant.posy], :size => composant.police
          @@vertex.push @text
        end
      end

    end

    def register

    end

    def render(win)
      win.clear Ray::Color.black
      @@vertex.each do |element|
        win.draw element
      end
    end

  end

  class Game < Ray::Game
    include Render
    def initialize
      super("RenderInterpret")
      Scene.bind(self)
      push_scene :stdout
    end

    def register
      add_hook :quit, method(:exit!)
    end

    def prepare(unContexteCible)
      @@contexte = unContexteCible
      @@vertex = Array.new
      run
    end

  end
end

# Tests
kWindow = Fenetre.creer("Picross L3-SPI", 0, 0, 0, 800, 600)
#kWindow.ajouterComposant(Button.creer("Partie rapide", 100, 50, 0, 150, 200))
#kWindow.ajouterComposant(Button.creer("Aventure", 200, 50, 0, 150, 200))
kWindow.ajouterComposant(Text.creer("Welcome-Message", "Bienvenue dans le jeu Picross L3-SPI", 12, 400, 50, 0))

Render::Game.new.prepare kWindow
