require 'openssl'

class Crypt

	@state
	@psw
	@processedPsw
	attr_reader :state
	attr_reader :id

	def initialize(password)
		@state = "Newborn"
		@psw=password
		@processedPsw = self.determinate_key
	end

	def determinate_key
		salt = "RoiDemonDu72"
		iter = 17158
		key_len = 12
		key = OpenSSL::PKCS5.pbkdf2_hmac_sha1(@psw, salt, iter, key_len)
		return key
	end

	def encrypt(dataToEncrypt)
		cipher = OpenSSL::Cipher::AES.new(128, :GCM)
		cipher.encrypt
		key = @processedPsw
		iv = 666
		if (ENV['USER'] != nil ) then
			cipher.auth_data = ENV['USER']
		else
			cipher.auth_data = ""
		end
		
		encrypted = cipher.update(dataToEncrypt) + cipher.final
		tag = cipher.auth_tag

		return encrypted
	end

	def decrypt(dataToDecrypt)
		decipher = OpenSSL::Cipher::AES.new(128, :GCM)
		decipher.decrypt
		decipher.key = @processedPsw
		decipher.iv = 666
		decipher.auth_tag = tag
		if (ENV['USER'] != nil ) then
			decipher.auth_data = ENV['USER']
		else
			decipher.auth_data = ""
		end

		plain = decipher.update(dataToDecrypt) + decipher.final
		return plain
	end

end