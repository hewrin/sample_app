class User < ActiveRecord::Base
  attr_accessor :remember_token
	before_save {self.email = email.downcase }
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
				format: {with: VALID_EMAIL_REGEX },
				uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }, allow_blank: true
	#method for password security, allows blank password so users don't need to change passwords.
	has_secure_password
  #Returns the hash digest of the given string, enforces password presence validations so users dont create accounts with no passwords  
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  #creates a new random token
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token)) 
  end
  #Returns true if the given token matches the digest
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end


end
