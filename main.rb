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
    initializeGame()
    #@kMainMenu.ajouterComposant(Audio.creer("Env", "ressources/son/BackgroundMusicLoop/BackgroundMusicLoop_BPM100.wav", true, 1, 1, 0, 0, 0))

  end

  def getMatrice()
    lastLevel = @kRegistre.getValue("lastLevel")
    levels = Dir["ressources/images/imagesPicross/BMP24bitsRVB/*.bmp"]
    if (lastLevel != nil)
      BMP::Reader.creer("ressources/images/imagesPicross/BMP24bitsRVB/#{levels[lastLevel]}").getMatrice
    else
      BMP::Reader.creer("ressources/images/imagesPicross/BMP24bitsRVB/x5_1.bmp").getMatrice
    end
  end

  def initializeMainMenu()

    background = Image.creer("Background", "ressources/images/GUI/Prototypes/background-4.jpg", 0, 0, 0)
    libell_alpha = Text.creer("alpha-prev", "alpha-preview 1", 15, 10, 10, 0)
    libell_title = Text.creer("title", "Picross B", 50, 250, 150, 0)
    libell_title.setPolice "ressources/ttf/Starjedi.ttf"
    btn_aventure = Boutton.creer("Aventure", 50, 50, 0, 0, 0)
    btn_newGame = Boutton.creer("Partie rapide", 50, 100, 0, 0, 0)
    btn_params = Boutton.creer("Parametres", 50, 150, 0, 0, 0)
    btn_quit = Boutton.creer("Quitter", 50, 200, 0, 0, 0)

    @kMainMenu.ajouterComposant(background)
    @kMainMenu.ajouterComposant(libell_alpha)
    @kMainMenu.ajouterComposant(libell_title)

    @kMainMenu.ajouterComposant(btn_aventure)
    @kMainMenu.ajouterComposant(btn_newGame)
    @kMainMenu.ajouterComposant(btn_params)
    @kMainMenu.ajouterComposant(btn_quit)

  end

  def initializeGame()
    @kInGame.supprimeTout

    background = Image.creer("Background", "ressources/images/GUI/Prototypes/background-4.jpg", 0, 0, 0)
    libell_alpha = Text.creer("alpha-prev", "alpha-preview 1", 15, 10, 10, 0)

    myMat = getMatrice
    #puts myMat.length
    if (myMat.length == 10)
      support_grille = Image.creer("Grille", "ressources/images/Grilles/v3/g10x10.png", 50, 25, 0)
    elsif (myMat.length == 5)
      support_grille = Image.creer("Grille", "ressources/images/Grilles/v3/g5x5.png", 50, 25, 0)
    elsif (myMat.length == 15)
      support_grille = Image.creer("Grille", "ressources/images/Grilles/v3/g15x15.png", 50, 25, 0)
    elsif (myMat.length == 20)
      support_grille = Image.creer("Grille", "ressources/images/Grilles/v3/g20x20.png", 50, 25, 0)
    end

    @currentGame = Grille.grille(myMat)

    btn_quit = Boutton.creer("Retour", 50, 430, 0, 0, 0)
    btn_help = Boutton.creer("Aide", 150, 430, 0, 0, 0)

    @kInGame.ajouterComposant(background)
    @kInGame.ajouterComposant(libell_alpha)
    @kInGame.ajouterComposant(support_grille)

    inHautPosX = 180
    inHautPosY = 25

    @currentGame.indicesHaut.each do |indice|
      puts indice.to_s
      indice.each do |nb|
        @kInGame.ajouterComposant(Text.creer("ind-#{inHautPosX.to_s}-#{inHautPosY.to_s}", "#{nb.to_s}", 15, inHautPosX, inHautPosY, 0))
        inHautPosY += 15
      end
      inHautPosY = 25
      inHautPosX += 15
    end

    inHautPosX = 50
    inHautPosY = 145

    @currentGame.indicesCote.each do |indice|
      puts indice.to_s
      indice.each do |nb|
        @kInGame.ajouterComposant(Text.creer("ind-#{inHautPosX.to_s}-#{inHautPosY.to_s}", "#{nb.to_s}", 15, inHautPosX, inHautPosY, 0))
        inHautPosX += 15
      end
      inHautPosX = 50
      inHautPosY += 15
    end

    @kInGame.ajouterComposant(btn_quit)
    @kInGame.ajouterComposant(btn_help)
  end

  def lanceToi
    @kRender.prepare @kMainMenu
  end

  def handleActionMain(unIDComposant)
    @kMainMenu.listeComposant.each do |composant|
      if composant.id == unIDComposant
        if composant.designation == "Quitter"
          exit
        elsif composant.designation == "Partie rapide"
          #puts "Changement de scene.."
          @unIDScene = 1
          @kRender.end_scene @kInGame
        end
      end
    end
  end

  def handleActionGame(unIDComposant)
    @kInGame.listeComposant.each do |composant|
      #puts "#{composant.id} == #{unIDComposant} --> #{composant.designation}"
      if composant.id == unIDComposant
        if composant.designation == "Retour"
          @unIDScene = 0
          @kRender.end_scene @kMainMenu
        end
      end
    end
  end

  def update(unIDComposant)
    #puts "Attention: Evenement Trigger #{unIDComposant.to_s} sur scene = #{@unIDScene}"

    if (@unIDScene == 0)
      handleActionMain(unIDComposant)
    elsif(@unIDScene == 1)
      handleActionGame(unIDComposant)
    end

  end

end

#Lancement
#puts OpenSSL::Cipher.ciphers
kJeu = Jeu.new
#kJeu.test_bmp()
kJeu.lanceToi
