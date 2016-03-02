load './class/fenetreabs.class.rb'
load './class/button.class.rb'
load './class/text.class.rb'
load './class/interfaceObject.class.rb'

require 'test/unit'



class TestAbstrait < Test::Unit::TestCase 
  
  def testCreationFenetre
  	10.times{
  		Fenetreabs.new(100,100,0)
	}
  end

  def testCreationObjet
  	10.times{
  		InterfaceObject.new("test",0)
	}
  end

  def testCreationButton
  	10.times{
  		Button.new("test",0)
	}
  end

  def testCreationText
  	10.times{
  		Text.new("test",0, "ceci est un test")
	}
  end

end

