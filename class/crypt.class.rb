require 'openssl'

class Crypt

	@state
	@psw
	@processedPsw
	@iv
	attr_reader :state
	attr_reader :id

	def initialize(password)
		@state = "Newborn"
		@psw=password
		@processedPsw = self.determinate_key
		@iv="NikeAdidasDiorPhilips "
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
		return plain
	end
end