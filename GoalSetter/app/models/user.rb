class User < ActiveRecord::Base
  include Commentable

  validates :username, :password_digest, :cheer_count, :session_token, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}
  after_initialize :ensure_session_token, :ensure_cheer_count

  has_many :cheers, inverse_of: :user
  has_many :goals, inverse_of: :user

  has_many :authored_comments,
    class_name: "Comment",
    primary_key: :id,
    foreign_key: :author_id,
    inverse_of: :author

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def password
    @password
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def reset_session_token!
    self.update(session_token: self.class.generate_session_token)
    self.session_token
  end

  def ensure_cheer_count
    self.cheer_count ||= 10
  end

  def give_cheer(goal)
    if self.cheer_count <= 0
      errors[:base] << "You have no more cheer to give! Buy more cheer."
    elsif self.cheers.where(goal_id: goal.id).exists?
      errors[:base] << "You can't cheer something twice. Buy more cheer."
    else
      self.cheer_count -= 1
      self.cheers.new(goal_id: goal.id).save!
    end
  end
end
