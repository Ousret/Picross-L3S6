# Picross main program
# Version 0.1.1

require 'observer'

load './class/bmp.class.rb'
load './class/crypt.class.rb'
load './class/registre.class.rb'

load './class/grille.class.rb'

load './class/objetgui.class.rb'
load './class/fenetre.class.rb'
load './class/button.class.rb'
load './class/saisie.class.rb'
load './class/text.class.rb'

load './class/render.class.rb'


class Jeu

  def initialize()

    @kRender = Render::Game.new
    @kRender.game_scenes.add_observer(self) #Pattern Observable

    @kRegistre = Registre.creer("picross-b.db")

    @unIDScene = 0

    @kMainMenu = Fenetre.creer("Menu principal", 0, 0, 0, 640, 480)
    @kInGame = Fenetre.creer("Jeu", 0, 0, 0, 640, 480)
    @kOpenWorld = Fenetre.creer("Aventure", 0, 0, 0, 640, 480)

    initializeMainMenu()
    #@kMainMenu.ajouterComposant(Audio.creer("Env", "ressources/son/BackgroundMusicLoop/BackgroundMusicLoop_BPM100.wav", true, 1, 1, 0, 0, 0))

  end

  def initializeMainMenu()

    background = Image.creer("Background", "ressources/images/GUI/Prototypes/background-4.jpg", 0, 0, 0)
    libell_alpha = Text.creer("alpha-prev", "alpha-preview 1", 15, 10, 10, 0)
    btn_aventure = Boutton.creer("Aventure", 50, 50, 0, 0, 0)
    btn_newGame = Boutton.creer("Partie rapide", 50, 100, 0, 0, 0)
    btn_params = Boutton.creer("Parametres", 50, 150, 0, 0, 0)
    btn_quit = Boutton.creer("Quitter", 50, 200, 0, 0, 0)

    @kMainMenu.ajouterComposant(background)
    @kMainMenu.ajouterComposant(libell_alpha)
    @kMainMenu.ajouterComposant(btn_aventure)
    @kMainMenu.ajouterComposant(btn_newGame)
    @kMainMenu.ajouterComposant(btn_params)
    @kMainMenu.ajouterComposant(btn_quit)

  end

  def lanceToi
    @kRender.prepare @kMainMenu
  end

  def handleActionMain(unIDComposant)
    @kMainMenu.listeComposant.each do |composant|
      if composant.id == unIDComposant
        if composant.designation == "Quitter"
          exit
        end
      end
    end
  end

  def update(unIDComposant)
    puts "Attention: Evenement Trigger #{unIDComposant.to_s}"

    if (@unIDScene == 0)
      handleActionMain(unIDComposant)
    end

  end

end

#Lancement
#puts OpenSSL::Cipher.ciphers
kJeu = Jeu.new
kJeu.lanceToi
