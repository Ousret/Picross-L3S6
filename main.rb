# Picross main program
# Version 0.2

require 'observer'
require 'json'
require 'curb'

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

# Classe de "haut-niveau" utilise les briques fondamentales
class Jeu

  FAST_GAME = "Partie rapide"
  ADVENTURE = "Aventure"
  QUIT = "Quitter"
  BACK = "Retour"
  URL_FETCH = "http://hop3x.univ-lemans.fr/picross/levels.json"

  def initialize()

    @kRender = Render::Game.new
    @kRender.game_scenes.add_observer(self) #Pattern Observable

    @kRegistre = Registre.creer("picross-b.db")
    @currentGame = nil

    @kMainMenu = Fenetre.creer("Menu principal", 0, 0, 0, 640, 480)
    @kInGame = Fenetre.creer("Jeu", 0, 0, 0, 640, 480)
    @kAbout = Fenetre.creer("À propos", 0, 0, 0, 640, 480)

    # Récupère les statistiques du disque local
    getStats

    # Si on ne dispose d'aucun niveau, on install ceux présent sur le disque
    install if @nLevel == nil || @nLevel == 0
    puts "Programme chargée avec #{@nLevel} niveau(x).."
    #@kMainMenu.ajouterComposant(Audio.creer("Env", "ressources/son/BackgroundMusicLoop/BackgroundMusicLoop_BPM100.wav", true, 1, 1, 0, 0, 0))

  end

  def fetchOnline
    request = Curl.get(URL_FETCH)
    return false if request.status != "200 OK" || request.status != "301 OK"
    return request.body_str
  end

  def getStats
    # Récupération des données
    @lastLevel = @kRegistre.getValue("lastLevel") || "1"
    @coins = @kRegistre.getValue("coins") || "0"
    @nTry = @kRegistre.getValue("try") || "0"
    @nWin = @kRegistre.getValue("win") || "0"
    @nLevel = @kRegistre.getValue("nbLevels") || "0"
    # Convertir vers fixnum
    @lastLevel = @lastLevel.to_i if @lastLevel != nil
    @coins = @coins.to_i if @coins != nil
    @nTry = @nTry.to_i if @nTry != nil
    @nWin = @nWin.to_i if @nWin != nil
    @nLevel = @nLevel.to_i if @nLevel != nil
  end

  # Ajout une tentative dans statistiques
  def addTry
    @nTry += 1
    @kRegistre.updateParam("try", @nTry.to_s)
  end

  # Ajout une victoire dans statistiques
  def addWin
    @nWin += 1
    @lastLevel += 1
    @kRegistre.updateParam("win", @nWin.to_s)
    @kRegistre.updateParam("lastLevel", @lastLevel.to_s)
  end

  # Ajout de l'argent dans statistiques
  def addCoin(unNombreGems)
    @coins+=unNombreGems
    @kRegistre.updateParam("coins", @coins.to_s)
  end

  # Récupére la matrice du dernier niveau
  def getMatrice
    @lastLevel = 1 if @lastLevel == nil
    JSON.load(@kRegistre.getValue("level_#{@lastLevel}"))
  end

  # Installation des niveaux présent sur le disque (local)
  def install
    onlineLevels = fetchOnline
    uneListeNiveau = Dir["ressources/images/imagesPicross/BMP24bitsRVB/*.bmp"].sort
    i = 1

    if onlineLevels != false # Si les niveaux sont disponible en ligne
      puts "Installation des niveaux depuis le serveur distant.."
      arrayLevels = JSON.load(onlineLevels)
      arrayLevels.each do |level|
        @kRegistre.addParam("level_#{i}", level.to_json)
        i+=1
      end
    else # Récupération hors ligne
      puts "Installation des niveaux depuis le disque local.. (hors ligne)"
      uneListeNiveau.each do |unNiveau|
        @kRegistre.addParam("level_#{i}", BMP::Reader.creer(unNiveau).getMatrice.to_json)
        i+=1
      end
    end

    # On sauvegarde le nombre de niveau chargé
    @nLevel = i
    @kRegistre.addParam("nbLevels", i.to_s)
    @kRegistre.addParam("coins", "0")
    @kRegistre.addParam("try", "0")
    @kRegistre.addParam("win", "0")
    @kRegistre.addParam("lastLevel", "1")
  end

  # Prépare la boite pour affichage statistiques
  def addStatBox(unContexteCible)

    stat_support = Image.creer("Stat-background", "ressources/images/GUI/box/boxNormal.png", 480, 20, 1)

    libell_coins = Text.creer("coins", "Gems   : #{@coins||0}", 10, 500, 50, 2)
    libell_try = Text.creer("try", "Essai    : #{@nTry||0}", 10, 500, 60, 2)
    libell_win = Text.creer("win", "Victoire: #{@nWin||0}", 10, 500, 70, 2)
    libell_avancement = Text.creer("avancement", "Niveau: #{@lastLevel||0}/#{@nLevel||0}", 10, 500, 80, 2)

    unContexteCible.ajouterComposant(stat_support, libell_coins, libell_try, libell_win, libell_avancement)

  end

  # Préparation de la fenêtre À propos
  def initializeAbout

    @kAbout.supprimeTout
    # Image de fond
    background = Image.creer("Background", "ressources/images/GUI/Prototypes/background-6.png", 0, 0, 0)
    # Information sur version
    libell_alpha = Text.creer("beta-1", "beta-preview 1", 15, 100, 120, 1)
    # Placement du titre
    libell_title = Text.creer("title", "Picross B", 50, 100, 100, 1)
    libell_title.setPolice "ressources/ttf/Starjedi.ttf" #Police d'écriture spéciale pour le titre

    libell_line1 = Text.creer("about_1", "Jeu de Picross Grpe B", 12, 100, 200, 1)
    libell_line2 = Text.creer("about_2", "Projet de semestre 6 en L3 SPI", 12, 100, 215, 1)

    libell_line3 = Text.creer("about_3", "Moteur Jeu: Houssam",12, 100, 230, 1)
    libell_line4 = Text.creer("about_4", "RenduGL: Ahmed", 12, 100, 245, 1)
    libell_line5 = Text.creer("about_5", "Registre: Victorien, Ahmed",12, 100, 260, 1)
    libell_line6 = Text.creer("about_6", "Cryptage: Baptiste", 12,100, 275, 1)
    libell_line7 = Text.creer("about_7", "TDA GUI: Antoine, Ahmed",12, 100, 290, 1)
    libell_line8 = Text.creer("about_8", "BMP: Marius",12, 100, 305, 1)
    libell_line9 = Text.creer("about_9", "Recherches: Matthis",12, 100, 320, 1)

    btn_quit = Boutton.creer("Retour", 50, 400, 1, 0, 0)

    addStatBox @kAbout

    @kAbout.ajouterComposant background, libell_alpha, libell_title, libell_line1, libell_line2, libell_line3, libell_line4, libell_line5, libell_line6, libell_line7, libell_line8, libell_line9, btn_quit

  end

  # Préparation du menu principal
  def initializeMainMenu()

    @kMainMenu.supprimeTout

    # Image de fond
    background = Image.creer("Background", "ressources/images/GUI/Prototypes/background-5.png", 0, 0, 0)

    # Information sur version
    libell_alpha = Text.creer("beta-1", "beta-preview 1", 15, 250, 170, 1)

    # Statistique
    addStatBox @kMainMenu

    # Placement du titre
    libell_title = Text.creer("title", "Picross B", 50, 250, 150, 1)
    libell_title.setPolice "ressources/ttf/Starjedi.ttf" #Police d'écriture spéciale pour le titre

    # Création des boutons
    btn_aventure = Boutton.creer("Aventure", 40, 50, 1, 0, 0)
    btn_newGame = Boutton.creer("Partie rapide", 40, 100, 1, 0, 0)
    btn_params = Boutton.creer("Parametres", 40, 150, 1, 0, 0)
    btn_about = Boutton.creer("À propos", 40, 200, 1, 0, 0)
    btn_quit = Boutton.creer("Quitter", 40, 250, 1, 0, 0)

    # Ajout des composants sur la fenêtre primaire
    @kMainMenu.ajouterComposant(background, libell_alpha, libell_title ,btn_aventure, btn_newGame, btn_params,btn_about ,btn_quit)

  end

  # Préparation du jeu "rapide"
  def initializeGame
    @kInGame.supprimeTout

    background = Image.creer("Background", "ressources/maps/Couloirs-Resized.png", 0, 0, 0)

    libell_niveau = Text.creer("niveau", "Niveau #{@lastLevel}", 19, 50, 40, 1)
    libell_niveau.setPolice "ressources/ttf/Starjedi.ttf"

    # Statistique
    addStatBox @kInGame

    myMat = getMatrice
    support_grille = Image.creer("Grille", "ressources/images/Grilles/v3/g#{myMat.length}x#{myMat.length}.png", 120, 120, 1)

    @currentGame = Grille.grille(myMat)
    addTry # Ajout +1 aux essai (statistiques)

    btn_quit = Boutton.creer("Abandonner", 50, 430, 1, 0, 0)
    btn_help = Boutton.creer("Aide", 150, 430, 1, 0, 0)
    btn_save = Boutton.creer("Sauvegarder", 250, 430, 1, 0, 0)

    @kInGame.ajouterComposant(background, libell_niveau, support_grille)

    # On place des élements "case" pour grille
    inHautPosX = 244
    inHautPosY = 245

    (1..myMat.length).step(1) do |n|

      (1..myMat.length).step(1) do |j|
          spriteCase = Sprite.creer("case", "ressources/images/Grilles/Cases.png", 8, 1, inHautPosX, inHautPosY, 2, 0, 0)
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
        @kInGame.ajouterComposant(Text.creer("ind-#{inHautPosX}-#{inHautPosY}", "#{nb}", 15, inHautPosX, inHautPosY, 2))
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
        @kInGame.ajouterComposant(Text.creer("ind-#{inHautPosX}-#{inHautPosY}", "#{nb}", 15, inHautPosX, inHautPosY, 2))
        inHautPosX += 16
      end
      inHautPosY += 16
      inHautPosX = 120
    end

    # Ajout des sprites pour case noir et blanche
    @kInGame.ajouterComposant(btn_quit, btn_help, btn_save)
  end

  # Lance le jeu avec le menu principal
  def lanceToi
    initializeMainMenu #Préparation du menu principal
    @kRender.prepare @kMainMenu #Rendu des objets
  end

  # Gestion des actions sur le menu principal
  def actionOnMenu(unTypeEvenement, unComposantCible, unTexteEntree=nil)
    # Gestion des événements sur menu principal
    return if unTypeEvenement != 1 # On ne recherche que le clique souris
    btn_cible_libell = unComposantCible.designation

    if (btn_cible_libell == FAST_GAME) #Si le joueur clique sur "Partie rapide"
      #On charge le plateau
      initializeGame
      #On recharge le rendu
      @kRender.end_scene @kInGame
    elsif (btn_cible_libell == "Quitter")
      #On met fin au programme
      exit
    elsif (btn_cible_libell == "À propos")
      #On charge la fenêtre à propos
      initializeAbout
      @kRender.end_scene @kAbout
    end
  end

  # Gestion des actions sur le plateau de jeu
  def actionOnGame(unTypeEvenement, unComposantCible, unTexteEntree=nil)
    # Gestion des événements sur menu principal
    return if unTypeEvenement != 1 # On ne recherche que le clique souris
    btn_cible_libell = unComposantCible.designation

    if (btn_cible_libell == "Abandonner") #Si le joueur clique sur "Retour" depuis la séance de jeu
      #On charge le menu principal
      initializeMainMenu
      #On recharge le rendu
      @kRender.end_scene @kMainMenu
    elsif (unComposantCible.designation == "case" && unComposantCible.arr_data != [-1, -1])

      # On tente de noirsir la case
      if @currentGame.noirsirCase unComposantCible.arr_data[0], unComposantCible.arr_data[1]
        @kRender.game_scenes.animateSprite unComposantCible
        @kRender.game_scenes.instantSound "ressources/son/pop.wav"
      else
        @kRender.game_scenes.instantSound "ressources/son/beep.wav"
      end
      # On vérifie que l'état de la partie
      if @currentGame.terminer?
        #On ajoute une victoire
        addWin
        addCoin @currentGame.calculeScore
        initializeMainMenu
        @kRender.end_scene @kMainMenu
      end
    elsif (btn_cible_libell == "Aide")
      #On vérifie que le joueur a suffisament de credit
      if (@coins > 100*@lastLevel)
        caseCible = @currentGame.demanderAide
        if (caseCible != [-1, -1])
          @currentGame.noirsirCase caseCible[0], caseCible[1]
          @kRender.game_scenes.instantSound "ressources/son/pop.wav"
        end
      end
    elsif (btn_cible_libell == "Quitter")
      #On met fin au programme
      exit
    elsif (btn_cible_libell == "Sauvegarder")
      #On sauvegarde l'état de la partie

    end

  end

  # Gestion des événements sur fenêtre À propos
  def actionOnAbout(unTypeEvenement, unComposantCible, unTexteEntree=nil)
    # Gestion des événements sur menu principal
    return if unTypeEvenement != 1 # On ne recherche que le clique souris
    btn_cible_libell = unComposantCible.designation

    if (btn_cible_libell == "Retour")
      initializeMainMenu
      @kRender.end_scene @kMainMenu
    end

  end

  # Méthode de reception signal pour pattern observateur
  def update(unTypeEvenement, unComposantCible, unTexteEntree=nil)
    #puts "Attention: Evenement Trigger #{unComposantCible.designation} sur typeEvenement = #{unTypeEvenement} avec contexte = #{@kRender.getContext.designation}"

    #On redirige vers la méthode concernée
    if @kRender.getContext.designation == "Menu principal"
      actionOnMenu unTypeEvenement, unComposantCible
    elsif @kRender.getContext.designation == "Jeu"
      actionOnGame unTypeEvenement, unComposantCible
    elsif @kRender.getContext.designation == "À propos"
      actionOnAbout unTypeEvenement, unComposantCible
    end

  end

end

#Lancement
#puts OpenSSL::Cipher.ciphers
kJeu = Jeu.new
kJeu.lanceToi
