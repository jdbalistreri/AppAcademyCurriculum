class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, presence: true
  validates :session_token, :email, uniqueness: true

  after_initialize :ensure_session_token

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
  end



  private
    def ensure_session_token
      self.session_token ||= self.class.generate_session_token
    end
end
