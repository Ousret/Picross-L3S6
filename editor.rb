require 'observer'
require 'json'

load './class/bmp.class.rb'
load './class/crypt.class.rb'
load './class/registre.class.rb'

load './class/objetgui.class.rb'
load './class/fenetre.class.rb'
load './class/button.class.rb'
load './class/saisie.class.rb'
load './class/text.class.rb'

load './class/render.class.rb'

class Editeur

  def initialize

    @kRender = Render::Game.new
    @kRender.game_scenes.add_observer(self) #Pattern Observable
    @kRegistre = Registre.creer("editeur.db")

    @kChoice = Fenetre.creer("Selection de niveau", 0, 0, 0, 640, 480)
    @kEditor = Fenetre.creer("Editeur", 0, 0, 0, 640, 480)

    @niveauCurseur = 1

  end

  # Installation des niveaux present sur le disque
  def install

  end

  def prepareLevelSelection
    # Image de fond
    background = Image.creer("Background", "ressources/images/GUI/Prototypes/background-6.png", 0, 0, 0)
    # Information sur version
    libell_alpha = Text.creer("beta-1", "beta-preview 1", 15, 100, 120, 1)
    # Placement du titre
    libell_title = Text.creer("title", "Picross B", 50, 100, 100, 1)
    libell_title.setPolice "ressources/ttf/Starjedi.ttf" #Police d'écriture spéciale pour le titre

    libell_consigne = Text.creer("consigne", "Specifiez le numéro du niveau à éditer", 12, 100, 200, 1)
    libell_lvl = Text.creer("niveau-cible", "#{@niveauCurseur}", 31, 100, 250, 1)

    btn_quit = Boutton.creer("Quitter", 50, 400, 1, 0, 0)
    btn_edit = Boutton.creer("Editer", 150, 400, 1, 0, 0)
    btn_delete = Boutton.creer("Suprimmer", 250, 400, 1, 0, 0)
    btn_new = Boutton.creer("Nouveau", 350, 400, 1, 0, 0)

    @kChoice.ajouterComposant background, libell_alpha, libell_title, libell_consigne, btn_quit, btn_edit, btn_new, btn_delete, libell_lvl
  end

  def lanceToi
    prepareLevelSelection
    @kRender.prepare @kChoice
  end

  def actionOnChoice(unTypeEvenement, unComposantCible, unTexteCible = nil)
    if unComposantCible == nil && unTexteCible != nil
      @niveauCurseur = unTexteCible.to_s.to_i
      nouveauLibell = @kRender.game_scenes.getVertexIDFromName("niveau-cible")
      nouveauLibell.contenu = @niveauCurseur.to_s
      @kRender.game_scenes.updateComposant nouveauLibell
    elsif unComposantCible.designation == "Quitter"
      exit
    elsif unComposantCible.designation == "Editer"
      #Hey
    elsif unComposantCible.designation == "Supprimer"
      #Hey
    elsif unComposantCible.designation == "Nouveau"
      #Ho!
    end
  end

  def update(unTypeEvenement, unComposantCible, unTexteCible = nil)
    #puts "Attention: Evenement Trigger #{unComposantCible.designation} sur typeEvenement = #{unTypeEvenement} avec contexte = #{@kRender.getContext.designation}"
    if @kRender.getContext.designation == "Selection de niveau"
      actionOnChoice unTypeEvenement, unComposantCible, unTexteCible
    end
  end

end

kEditor = Editeur.new
kEditor.lanceToi
