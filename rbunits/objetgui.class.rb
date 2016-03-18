require 'test/unit'
load './class/objetgui.class.rb'
load './class/fenetre.class.rb'
load './class/button.class.rb'
load './class/saisie.class.rb'
load './class/text.class.rb'

class TestObjetGUI < Test::Unit::TestCase
	def test_container
		kWindow = Fenetre.creer("Picross L3-SPI", 0, 0, 800, 600)
		kWindow.ajouterComposant(Button.creer("Partie rapide", 100, 50, 150, 200))
		kWindow.ajouterComposant(Button.creer("Aventure", 200, 50, 150, 200))
		kWindow.ajouterComposant(Text.creer("Welcome-Message", "Bienvenue dans le jeu Picross L3-SPI", 12, 400, 10, 0))
	end
end
