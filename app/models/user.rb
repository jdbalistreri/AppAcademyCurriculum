class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, presence: true
  validates :session_token, :email, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token

  has_many :notes

  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def is_password?(value)
    BCrypt::Password.new(password_digest).is_password?(value)
  end

  def password=(value)
    self.password_digest = BCrypt::Password.create(value)
    @password = value
  end

  def password
    @password
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  private
    def ensure_session_token
      self.session_token ||= self.class.generate_session_token
    end
end
