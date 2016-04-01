require 'test/unit'
load './class/objetgui.class.rb'
load './class/fenetre.class.rb'
load './class/button.class.rb'
load './class/saisie.class.rb'
load './class/text.class.rb'

class TestObjetGUI < Test::Unit::TestCase
	def test_container
    #Sur un même plan Z=0
		kWindow = Fenetre.creer("Picross L3-SPI", 0, 0, 0, 800, 600)
		kWindow.ajouterComposant(Boutton.creer("Partie rapide", 100, 50, 0, 150, 200))
		kWindow.ajouterComposant(Boutton.creer("Aventure", 200, 50, 0, 150, 200))
		kWindow.ajouterComposant(Text.creer("Welcome-Message", "Bienvenue dans le jeu Picross L3-SPI", 12, 400, 50, 0))
	end
end
