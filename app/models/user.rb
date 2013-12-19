class User < ActiveRecord::Base
	has_many :customers, foreign_key: "csm_id"
	has_many :tasks, foreign_key: "csm_id"
	#has_many :tasks, through: :customers
	before_save {self.email = email.downcase}
	before_create :create_remember_token
	#before_save {email.downcase!} #alternate method
	validates :name, presence: true, length: {maximum: 50}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: true, 
			format: {with: VALID_EMAIL_REGEX},
			uniqueness: {case_sensitive: false}
	has_secure_password
	validates :password, format: {with: /\A(?=.*[a-zA-Z])(?=.*[0-9]).{8,}\z/, message: "must be at least 8 characters and include one number and letter"}

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def self.search(search)
		if search
			where 'name LIKE ?', "%#{search}%"
		else
			scoped
		end
	end

	private
		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end
end
