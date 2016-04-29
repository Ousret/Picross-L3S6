# Picross main program
# Version 0.2

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
    @currentGame = nil

    @kMainMenu = Fenetre.creer("Menu principal", 0, 0, 0, 640, 480)
    @kInGame = Fenetre.creer("Jeu", 0, 0, 0, 640, 480)

    #@kMainMenu.ajouterComposant(Audio.creer("Env", "ressources/son/BackgroundMusicLoop/BackgroundMusicLoop_BPM100.wav", true, 1, 1, 0, 0, 0))

  end

  def getMatrice()
    lastLevel = @kRegistre.getValue("lastLevel")
    levels = Dir["ressources/images/imagesPicross/BMP24bitsRVB/*.bmp"].sort
    if (lastLevel != nil)
      BMP::Reader.creer(levels[lastLevel.to_i]).getMatrice
    else
      @kRegistre.addParam('lastLevel', '1')
      BMP::Reader.creer("ressources/images/imagesPicross/BMP24bitsRVB/x10_2.bmp").getMatrice
    end
  end

  def initializeMainMenu()

    # Image de fond
    background = Image.creer("Background", "ressources/images/GUI/Prototypes/background-4.jpg", 0, 0, 0)

    # Information sur version
    libell_alpha = Text.creer("alpha-prev", "alpha-preview 1", 15, 10, 10, 0)

    # Placement du titre
    libell_title = Text.creer("title", "Picross B", 50, 250, 150, 0)
    libell_title.setPolice "ressources/ttf/Starjedi.ttf"

    # Création des boutons
    btn_aventure = Boutton.creer("Aventure", 50, 50, 0, 0, 0)
    btn_newGame = Boutton.creer("Partie rapide", 50, 100, 0, 0, 0)
    btn_params = Boutton.creer("Parametres", 50, 150, 0, 0, 0)
    btn_quit = Boutton.creer("Quitter", 50, 200, 0, 0, 0)

    # Ajout des composants sur la fenêtre primaire
    @kMainMenu.ajouterComposant(background, libell_alpha, libell_title, btn_aventure, btn_newGame, btn_params, btn_quit)

  end

  def initializeGame()
    @kInGame.supprimeTout

    background = Image.creer("Background", "ressources/maps/Couloirs-Resized.png", 0, 0, 0)
    libell_alpha = Text.creer("alpha-prev", "alpha-preview 1", 15, 50, 50, 1)
    libell_score = Text.creer("score", "Score: 0", 15, 400, 50, 1)

    myMat = getMatrice

    if (myMat.length == 10)
      support_grille = Image.creer("Grille", "ressources/images/Grilles/v3/g10x10.png", 120, 120, 1)
    elsif (myMat.length == 5)
      support_grille = Image.creer("Grille", "ressources/images/Grilles/v3/g5x5.png", 120, 120, 1)
    elsif (myMat.length == 15)
      support_grille = Image.creer("Grille", "ressources/images/Grilles/v3/g15x15.png", 120, 120, 1)
    elsif (myMat.length == 20)
      support_grille = Image.creer("Grille", "ressources/images/Grilles/v3/g20x20.png", 120, 120, 1)
    end

    @currentGame = Grille.grille(myMat)

    btn_quit = Boutton.creer("Retour", 50, 430, 1, 0, 0)
    btn_help = Boutton.creer("Aide", 150, 430, 1, 0, 0)

    @kInGame.ajouterComposant(background, libell_alpha, libell_score, support_grille)

    # On place des élements "case" pour grille
    inHautPosX = 244
    inHautPosY = 245

    (1..myMat.length).step(1) do |n|

      (1..myMat.length).step(1) do |j|
          spriteCase = Sprite.creer("case-#{inHautPosX.to_s}-#{inHautPosY.to_s}", "ressources/images/Grilles/Cases.png", 8, 1, inHautPosX, inHautPosY, 2, 0, 0)
          spriteCase.arr_data = [n, j]
          spriteCase.deplacer 1, 0
          @kInGame.ajouterComposant(spriteCase)

          inHautPosX += 16
      end

      inHautPosX = 244
      inHautPosY += 16

    end

    # Positionnement des indices Haut
    inHautPosX = 250
    inHautPosY = 120

    @currentGame.indicesHaut.each do |indice|
      indice.each do |nb|
        @kInGame.ajouterComposant(Text.creer("ind-#{inHautPosX.to_s}-#{inHautPosY.to_s}", "#{nb.to_s}", 15, inHautPosX, inHautPosY, 2))
        inHautPosY += 16
      end
      inHautPosX += 16
      inHautPosY = 120
    end

    # Positionnement des indices Coté
    inHautPosX = 120
    inHautPosY = 240

    @currentGame.indicesCote.each do |indice|
      indice.each do |nb|
        @kInGame.ajouterComposant(Text.creer("ind-#{inHautPosX.to_s}-#{inHautPosY.to_s}", "#{nb.to_s}", 15, inHautPosX, inHautPosY, 2))
        inHautPosX += 16
      end
      inHautPosY += 16
      inHautPosX = 120
    end

    # Ajout des sprites pour case noir et blanche
    @kInGame.ajouterComposant(btn_quit, btn_help)
  end

  def lanceToi
    initializeMainMenu #Préparation du menu principal
    @kRender.prepare @kMainMenu #Rendu des objets
  end

  def update(unTypeEvenement, unComposantCible)
    puts "Attention: Evenement Trigger #{unComposantCible.designation} sur typeEvenement = #{unTypeEvenement.to_s} avec contexte = #{@kRender.getContext.designation}"
    if (unTypeEvenement == 1)
      if (unComposantCible.designation == 'Partie rapide')
        # Préparation de la fenêtre partie rapide
        initializeGame
        @kRender.end_scene @kInGame
      elsif (unComposantCible.designation == 'Retour')
        @kRender.end_scene @kMainMenu
      elsif (unComposantCible.arr_data != [-1, -1])
        if @currentGame.noirsirCase unComposantCible.arr_data[0], unComposantCible.arr_data[1]
          @kRender.game_scenes.animateSprite unComposantCible
        end
      end
    end
  end

end

#Lancement
#puts OpenSSL::Cipher.ciphers
kJeu = Jeu.new
kJeu.lanceToi
