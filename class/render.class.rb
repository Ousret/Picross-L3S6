# Classe interpreteur objet fenêtre vers rendu GL(UT)
# Necessite OpenAL, OpenGL, FreeType, LibSnd
# (c) 2016 - Groupe B - Picross L3 SPI Informatique
# Université du Maine

require 'observer'
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
    include Observable
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
      @sound = music unComposant.path
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
      #@image.origin = @image.image.size / 2
      @image.pos = [unComposant.posx, unComposant.posy]
      @image
    end

    # Créer un calque sprite statique (sans translation)
    # * *Arguments*
    #   - +unComposant+ -> Objet décrivant l'image sprite
    def createSprite(unComposant)
      @sprite = sprite unComposant.source
      @sprite.sheet_size = [unComposant.dimx, unComposant.dimy] # Dimention du Sprite
      @sprite.pos = [unComposant.posx, unComposant.posy]
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

          @image = createImage composant
          @@vertex.push @image
          composant.taillex = @image.image.size.to_a[0]
          composant.tailley = @image.image.size.to_a[1]

          composant.id = @@vertex.index(@image)

        elsif (composant.instance_of? Boutton)
          #Charge l'image boutton
          @button = Ray::Sprite.new "ressources/images/GUI/btn_spr_m.png"
          @button.pos = [composant.posx, composant.posy]
          @button.sheet_size = [2, 9]
          #On place un texte
          @text = text composant.designation, :at => [composant.posx+5, composant.posy+5], :size => 12

          composant.taillex = @button.image.size.to_a[0]/2
          composant.tailley = @button.image.size.to_a[1]/9

          puts "Création boutton #{composant.designation}: TailleX = #{composant.taillex}, TailleY = #{composant.tailley}"
          puts "PosX = #{composant.posx}, PosY = #{composant.posy}"

          @@vertex.push @button
          @@vertex.push @text

          composant.id = @@vertex.index(@button)

        elsif (composant.instance_of? Sprite)
          @@vertex.push createSprite composant
        end

      end

      # Prépare la boucle de rafraichissement
      setAnimations

    end

    def setAnimations
      #Boucle de rafraichissement
      always do
        @@contexte.listeComposant.each do |composant|
          if (composant.instance_of? Boutton)
            if (composant.isOver(mouse_pos.to_a[0], mouse_pos.to_a[1]) && !composant.survol)
              #changed
              createSpriteAnimation composant.id, [0, 1], [1, 1], 0.2
              composant.survol = true
              #notify_observers(composant.id)
            elsif (composant.survol && !composant.isOver(mouse_pos.to_a[0], mouse_pos.to_a[1]))
              createSpriteAnimation composant.id, [1, 1], [0, 1], 0.2
              composant.survol = false
            end
          else
            if (composant.isOver(mouse_pos.to_a[0], mouse_pos.to_a[1]) && !composant.survol)
              composant.survol = true
            elsif (composant.survol && !composant.isOver(mouse_pos.to_a[0], mouse_pos.to_a[1]))
              composant.survol = false
            end
          end
        end
        #if animations.empty?
        #end
      end
    end

    def eventMouse
      @@contexte.listeComposant.each do |composant|
        if composant.survol
          changed
          notify_observers(composant.id)
        end
      end
    end

    def createSpriteAnimation(unIdentifiantVertex, desIndicesDepart, desIndicesFin, uneDuree)
      animations << sprite_animation(:from => desIndicesDepart, :to => desIndicesFin, :duration => uneDuree).start(@@vertex[unIdentifiantVertex])
    end

    def register # :nodoc:
      add_hook :quit, method(:exit!)
      add_hook :mouse_press, method(:eventMouse)
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
    include Observable

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

    # Faire remonter la classe Scene pour pattern Observateur
    def game_scenes()
      @game_scenes.current
    end

  end
end
