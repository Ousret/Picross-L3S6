require 'openssl'
require 'faker'

# Author::    Bien-CV https://github.com/Bien-CV
# License::   MIT Licence
#
# https://github.com/Ousret/Picross-L3S6
#
#*Créer une instance de cette classe, en donnant en paramètre un mot de passe déterminé par lutilisateur,
#*utilise le PKCS5 pour sécuriser le mot de passe.
#*Appeler une instance de cette classe avec les méthodes encrypt(data) et decrypt(data) cryptera ou décryptera
#*les données fournies en paramètre grace à de l AES 128bits GCM en se servant du mot de passe crypté par le PKCS5
#*en clé de cryptage.
#

class Crypt

	#Indique le nombre de fois que la méthode encrypt a été utilisée
	@nbOfEncrypt
	#Indique le nombre de fois que la méthode decrypt a été utilisée
	@nbOfDecrypt
	#Est le mot de passe choisi et utilisé comme clé de cryptage, il est choisi lors de la création d'instance.
	@psw
	#Contient le hash du mot de passe 
	@processedPsw
	#Type d'encryptage choisi, AES 128 bits GCM par défault : Attention, certains encryptages ne seront pas supportés
	@cipherType
	#Vecteur d'initialisation de l'algorithme de cryptage, contient une valeur par défaut.
	@iv

	#Accesseurs
	attr_reader :nbOfEncrypt
	attr_reader :nbOfDecrypt

	#Prévoir de rendre privé la méthode hashLeMotDePasse

	#Empêche l'utilisation de la méthode new pour payer nos hommages à monsieur Jacoboni
	private_class_method :new


	#Méthode de création d'instance de la classe Crypt.
	#
	# * *Arguments*    :
	#   - +unPassword+ -> le mot de passe utilisé comme clé
	#   - +encryptionMethod+ -> La méthode d'encryption à utiliser, toutes ne sont pas supportées. ( cf https://docs.google.com/document/d/1Hdzg2B-U0fL_KFjIpdfWqLR6xUaBIzQuEXP7pZsM3V4/pub )
	#   - +chosenIv+ -> Le vecteur d'initialisation à utiliser.
	# * *Valeurs de retour* :
	#   - Une nouvelle instance de la classe Crypt.
	def Crypt.creerEncodeurDecodeur(unPassword,encryptionMethod='aes-128-gcm',chosenIv="NikeAdidasDiorPhilips")
		new(unPassword,encryptionMethod,chosenIv)
	end

	#Méthode d'initialisation utilisée lors de la création d'instance.
	#
	#
	# * *Arguments*    :
	#   - +unPassword+ -> le mot de passe utilisé comme clé
	#   - +encryptionMethod+ -> La méthode d'encryption à utiliser, toutes ne sont pas supportées. ( cf https://docs.google.com/document/d/1Hdzg2B-U0fL_KFjIpdfWqLR6xUaBIzQuEXP7pZsM3V4/pub )
	#   - +chosenIv+ -> Le vecteur d'initialisation à utiliser.
	# * *Valeurs de retour* :
	#   - Une nouvelle instance de la classe Crypt.
	def initialize(password,encryptionMethod,chosenIv)

		@psw = password

		@processedPsw = self.hashLeMotDePasse
		@cipherType = encryptionMethod
		@iv = chosenIv

		@nbOfEncrypt=0
		@nbOfDecrypt=0

	end

	#Methode qui hash le mot de passe en utilisant un sel aléatoire et PBKDF2
	#Est uniquement appelée lors de l'initialisation d'une nouvelle instance.
	#
	# * *Valeurs de retour* :
	#   - La clé de cryptage calculée selon le 
	def hashLeMotDePasse
		#Le salt ajoute une composante aléatoire évitant de casser l'algo d'encryption par Rainbow Tables.
		salt = OpenSSL::Random.random_bytes(24)
		iter = 17158
		key_len = 128
		key = OpenSSL::PKCS5.pbkdf2_hmac_sha1(@psw, salt, iter, key_len)
		return key
	end

	#Methode qui encrypte une chaine en utilisant le type d'encryption précisé lors de la création d'instance,
	#le hash du mot de passe précisé lors de la création d'instance,
	#le IV du mot de passe précisé lors de la création d'instance.
	#
	#Incrémente la variable d'instance nbOfEncrypt, qui compte le nombre d'encryptions effectuées par l'encodeur/décodeur.
	#
	# * *Arguments*    :
	#   - +stringToEncrypt+ -> la chaîne à encrypter
	# * *Valeurs de retour* :
	#   - La chaîne encryptée
	def encrypt(stringToEncrypt)
		cipher = OpenSSL::Cipher.new(@cipherType)
		cipher.encrypt
		cipher.key = @processedPsw
		cipher.iv = @iv
	
		encrypted = cipher.update(stringToEncrypt)
		#tag = cipher.auth_tag
		
		@nbOfEncrypt=@nbOfEncrypt+1
		return encrypted
	end

	#Methode qui décrypte une chaine en utilisant le type d'encryption précisé lors de la création d'instance,
	#le hash du mot de passe précisé lors de la création d'instance,
	#le IV du mot de passe précisé lors de la création d'instance.
	#
	#Incrémente la variable d'instance nbOfDecrypt, qui compte le nombre de décryptions effectuées par l'encodeur/décodeur.
	#
	# * *Arguments*    :
	#   - +stringToDecrypt+ -> la chaîne à décrypter
	# * *Valeurs de retour* :
	#   - La chaîne décryptée
	def decrypt(stringToDecrypt)
		decipher = OpenSSL::Cipher.new(@cipherType)
		decipher.decrypt
		decipher.key = @processedPsw
		decipher.iv = @iv

		plain = decipher.update(stringToDecrypt)
		@nbOfDecrypt=@nbOfDecrypt=+1
		return plain
	end

	
end
