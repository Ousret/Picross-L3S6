require 'openssl'

'''
Créer une instance de cette classe, en donnant en paramètre un mot de passe déterminé par l'utilisateur,
utilise le PKCS5 pour sécuriser le mot de passe.
Appeler une instance de cette classe avec les méthodes encrypt(data) et decrypt(data) cryptera ou décryptera
les données fournies en paramètre grace à de l'AES 128bits GCM en se servant du mot de passe crypté par le PKCS5
en clé de cryptage.
'''
class Crypt
	
	#Indique le nombre de fois que la méthode encrypt a été utilisée
	@nbOfEncrypt
	#Indique le nombre de fois que la méthode decrypt a été utilisée
	@nbOfDecrypt
	#Est le mot de passe choisi et utilisé comme clé de cryptage, il est choisi lors de la création d'instance.
	@psw
	#Contient le hash du mot de passe 
	@processedPsw
	@iv
	attr_reader :state
	attr_reader :id

	def initialize(password)
		@psw=password
		@processedPsw = self.determinate_key
		@iv="NikeAdidasDiorPhilips "
		@nbOfEncrypt=0
		@nbOfDecrypt=0
	end

	def determinate_key
		salt = "RoiDemonDu72"
		iter = 17158
		key_len = 128
		key = OpenSSL::PKCS5.pbkdf2_hmac_sha1(@psw, salt, iter, key_len)
		return key
	end

	def encrypt(dataToEncrypt)
		cipher = OpenSSL::Cipher.new('aes-128-gcm')
		cipher.encrypt
		cipher.key = @processedPsw
		cipher.iv = @iv
		if (ENV['USER'] != nil ) then
			cipher.auth_data = ENV['USER']
		else
			cipher.auth_data = ""
		end
		encrypted = cipher.update(dataToEncrypt)
		#tag = cipher.auth_tag
		
		@nbOfDecrypt=@nbOfDecrypt+1
		return encrypted
	end

	def decrypt(dataToDecrypt)
		decipher = OpenSSL::Cipher.new('aes-128-gcm')
		decipher.decrypt
		decipher.key = @processedPsw
		decipher.iv = @iv
		decipher.auth_tag = ENV['USER']
		if (ENV['USER'] != nil ) then
			decipher.auth_data = ENV['USER']
		else
			decipher.auth_data = ""
		end

		plain = decipher.update(dataToDecrypt)
		@nbOfDecrypt=@nbOfDecrypt=+1
		return plain
	end
end
