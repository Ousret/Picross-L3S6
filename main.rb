# Picross main program
# Version 0.1.1

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

    @kMainMenu = Fenetre.creer("Picross B - Menu principal", 0, 0, 0, 800, 600)

    @kMainMenu.ajouterComposant(Image.creer("Background", "ressources/images/GUI/Prototypes/Background.png", 0, 0, 0))
    @kMainMenu.ajouterComposant(Text.creer("alpha-prev", "alpha-preview 1", 15, 10, 10, 0))

    @kMainMenu.ajouterComposant(Boutton.creer("Aventure", 50, 50, 0, 0, 0))
    @kMainMenu.ajouterComposant(Boutton.creer("Partie rapide", 50, 100, 0, 0, 0))
    @kMainMenu.ajouterComposant(Boutton.creer("Paramétres", 50, 150, 0, 0, 0))

    @kMainMenu.ajouterComposant(Audio.creer("Env", "ressources/son/BackgroundMusicLoop/BackgroundMusicLoop_BPM100.wav", true, 1, 1, 0, 0, 0))

  end

  def lanceToi
    @kRender.prepare @kMainMenu
  end

end

#Lancement

kJeu = Jeu.new
kJeu.lanceToi
