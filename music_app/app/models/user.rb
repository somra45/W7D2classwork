class User < ApplicationRecord
    before_validation :ensure_session_token
    attr_reader :password
    
    validates :email, presence: true, uniqueness: {case_sensitive: true}
    validates :session_token, presence: true, uniqueness: {case_sensitive: true}
    validates :password_digest, presence: true
    validates :password, length: {minimum: 6}, allow_nil: true
    
    def self.find_by_credentials(email, password)
        user = User.find_by(email: email)

        if user && user.is_password?(password)
            user
        else
            nil
        end
    end

    def is_password?(password)
        password_object = BCrypt::Password.new(password_digest)
        password_object.is_password?(password)
    end

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password
    end

    def generate_session_token
        SecureRandom.urlsafe_base64
    end

    def ensure_session_token
        self.session_token ||= SecureRandom.urlsafe_base64
    end

    def reset_session_token!
        self.session_token = SecureRandom.urlsafe_base64
        self.save!
    end
end
