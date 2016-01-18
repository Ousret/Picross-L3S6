class Crypt

	@@id=0
	@state
	attr_reader :state

	def initialize()
		@state = "operationnel"
		@@id += 1
	end

end