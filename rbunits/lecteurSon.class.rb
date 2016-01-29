
require 'gosu'
require 'test/unit'
load './class/lecteurSon.class.rb'
load './class/fenetre.class.rb'




class TestLecteurSon < Test::Unit::TestCase 
  window = GameWindow.new
  test = LecteurSon.new("./ressources/son/test1.wav")
  window.show

end