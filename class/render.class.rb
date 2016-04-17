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

# Module de rendu GL
module Render

  # Contient la description en TDA de l'aspect GUI
  @@contexte = Array.new
  # Contient l'ensemble des textures prêtes au rendu GL
  @@vertex = Array.new
  # Contient l'ensemble des sons
  @@tracks = Array.new

  # Classe représentant la scene en sortie standard
  class Scene < Ray::Scene
    #Partage de variable de classe avec Game
    include Render
    scene_name :stdout

    # Créer un calque Texte
    # * *Arguments*
    #   - +unComposant+ -> Objet décrivant le texte
    def createText(unComposant)
      text unComposant.contenu, :at => [unComposant.posx, unComposant.posy], :size => unComposant.police, :font => unComposant.ttf
    end

    # Charge un fichier audio en mémoire (libsnd native)
    # * *Arguments*
    #   - +unComposant+ -> Objet décrivant la piste audio
    def createAudio(unComposant)
      @sound = music path_of(unComposant.path)
      @sound.attenuation  = unComposant.attenuation
      @sound.min_distance = 10
      @sound.pos          = [unComposant.posx, unComposant.posy, unComposant.posz]
      @sound.looping      = unComposant.infinite
      @sound.pitch        = unComposant.pitch
      @sound.relative     = false
      @sound
    end

    # Créer un calque à partir d'une image (PNG, JPEG, BMP)
    # * *Arguments*
    #   - +unComposant+ -> Objet décrivant l'image
    def createImage(unComposant)
      @image = Ray::Sprite.new unComposant.path
      @image.origin = @image.image.size / 2
      @image.pos = [unComposant.posx, unComposant.posy]
      @image
    end

    # Créer un calque sprite statique (sans translation)
    # * *Arguments*
    #   - +unComposant+ -> Objet décrivant l'image sprite
    def createSprite(unComposant)
      @sprite = sprite unComposant.source
      @sprite.sheet_size = [unComposant.dimx, unComposant.dimy] # Dimention du Sprite
      @sprite
    end

    # Préparation et interpretation du contexte
    def setup

      window.size = [@@contexte.taillex, @@contexte.tailley]
      window.title = @@contexte.designation

      #Charge/prépare l'ensemble des elements pour affichage graphique
      @@contexte.listeComposant.each do |composant|
        puts "Initialisation du composant #{composant.designation}"
        if (composant.instance_of? Text)

          @@vertex.push createText composant

        elsif (composant.instance_of? Audio)
          @audio = createAudio composant
          @@tracks.push @audio

          if (composant.infinite)
            @audio.play
          end

        elsif (composant.instance_of? Image)

          @@vertex.push createImage composant

        elsif (composant.instance_of? Boutton)
          #Charge l'image boutton
          @image = Ray::Sprite.new "ressources/images/GUI/button_base_clicked_d1l1.png"
          @image.origin = @image.image.size / 2
          @image.pos = [composant.posx, composant.posy]
          @text = text composant.designation, :at => [composant.posx+20, composant.posy+20], :size => 12
          @@vertex.push @image
          @@vertex.push @text
        elsif (composant.instance_of? Sprite)
          @@vertex.push createSprite composant
        end
      end

    end

    def register # :nodoc:

    end

    def render(win) # :nodoc:
      win.clear Ray::Color.black
      @@vertex.each do |element|
        win.draw element
      end
    end

  end

  # Classe de gestion du Jeu
  class Game < Ray::Game
    #Permet de partager les variables de classes entre Game et Scene
    include Render

    def initialize # :nodoc:
      super("RenderInterpret")
      Scene.bind(self)
      push_scene :stdout
    end

    def register
      add_hook :quit, method(:exit!)
    end

    # Prépare le rendu en assignant le contexte à une variable de module
    # * *Arguments*
    #   - +unContexteCible+ -> Objet décrivant la fenêtre cible
    def prepare(unContexteCible)
      @@contexte = unContexteCible
      @@vertex = Array.new
      @@tracks = Array.new
      run
    end

  end
end

# Tests
kWindow = Fenetre.creer("Picross L3-SPI", 0, 0, 0, 800, 600)
#kWindow.ajouterComposant(Boutton.creer("Partie rapide", 100, 50, 0, 150, 200))
kWindow.ajouterComposant(Image.creer("ImageTest", "ressources/maps/OpenWorld3.png", 250, 20, 0))
#kWindow.ajouterComposant(Boutton.creer("Aventure", 200, 50, 0, 150, 200))
kWindow.ajouterComposant(Text.creer("Welcome-Message", "alpha-preview 1", 15, 20, 20, 0))
kWindow.ajouterComposant(Sprite.creer("SpriteHero", "ressources/images/sprites/Characters/MrYtdBCF.png", 13, 21, 20, 20, 0, 100, 100))

Thread.new {Render::Game.new.prepare kWindow}
