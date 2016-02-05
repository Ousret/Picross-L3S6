load 'interfaceObject.class.rb'

class Button < InterfaceObject

	def initialize(nom,option)
		super("test",0)
		#state=false
	end

	def setup(width, height, posX, posY, option)
	end

	def state
	end

	def isActive?
	end

	def update(image)
	end

end