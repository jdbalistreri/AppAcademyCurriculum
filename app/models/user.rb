class User < ActiveRecord::Base
  validates :username, :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 6,  allow_null: true }

  after_initialize :ensure_session_token

  def self.generate_session_token
    token = SecureRandom::urlsafe_base64
    generate_session_token if User.exists?(session_token: token)
    token
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def password
    @password
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  private
    def ensure_session_token
      self.session_token ||= self.class.generate_session_token
    end
end
