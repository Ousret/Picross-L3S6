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
load './class/image.class.rb'
load './class/audio.class.rb'
load './class/sprite.class.rb'

module Render

  @@contexte = Array.new
  @@vertex = Array.new

  class Scene < Ray::Scene
    #Partage de variable de classe avec Game
    include Render
    scene_name :stdout

    def setup

      window.size = [@@contexte.taillex, @@contexte.tailley]
      window.title = @@contexte.designation

      #Set ressource on screen
      @@contexte.listeComposant.each do |composant|
        puts "Initialisation du composant #{composant.designation}"
        if (composant.instance_of? Text)
          @text = text composant.contenu, :at => [composant.posx, composant.posy], :size => composant.police
          @@vertex.push @text
        elsif (composant.instance_of? Audio)
          @sound = music path_of(composant.path)
          @sound.attenuation  = composant.attenuation
          @sound.min_distance = 10
          @sound.pos          = [composant.posx, composant.posy, composant.posz]
          @sound.looping      = composant.infinite
          @sound.pitch        = composant.pitch
          @sound.relative     = false

          @sound.play
        elsif (composant.instance_of? Sprite)
          @sprite = sprite composant.source
          @sprite.sheet_size = [composant.dimx, composant.dimy] # Dimention du Sprite
          always do
            if animations.empty?
              # Si on appuis sur une fleche directionnel bas/gauche/droite/haut
              if holding? :down
                # Le sprite passe de l'etat actuel a l'annimation etat[0,2]=>etat[4,2] en 0,3 seconde
                animations << sprite_animation(:from => [0, 2], :to => [4, 2],
                                               :duration => 0.3).start(@sprite)
                animations << translation(:of => [0, 32], :duration => 0.3).start(@sprite)
              elsif holding? :left
                animations << sprite_animation(:from => [0, 1], :to => [4, 1],
                                               :duration => 0.3).start(@sprite)
                animations << translation(:of => [-32, 0], :duration => 0.3).start(@sprite)
              elsif holding? :right
                animations << sprite_animation(:from => [0, 3], :to => [4, 3],
                                               :duration => 0.3).start(@sprite)
                animations << translation(:of => [32, 0], :duration => 0.3).start(@sprite)
              elsif holding? :up
                animations << sprite_animation(:from => [0, 0], :to => [4, 0],
                                               :duration => 0.3).start(@sprite)
                animations << translation(:of => [0, -32], :duration => 0.3).start(@sprite)
              end
            end
          end
          @@vertex.push @sprite
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
    #Permet de partager les variables de classes entre Game et Scene
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
kWindow.ajouterComposant(Text.creer("Welcome-Message", "Bienvenue dans le jeu Picross L3-SPI", 12, 20, 300, 0))
kWindow.ajouterComposant(Sprite.creer("SpriteHero", "ressources/images/sprites/Characters/MrYtdBCF.png", 13, 21, 20, 20, 0, 100, 100))

Render::Game.new.prepare kWindow
