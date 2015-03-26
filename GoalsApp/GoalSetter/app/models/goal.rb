class Goal < ActiveRecord::Base
  include Commentable

  validates :title, :description, :user, :privacy, presence: true
  enum privacy: [ :open, :closed ]

  belongs_to :user, inverse_of: :goals
  has_many :cheers, inverse_of: :goal

  def user_name
    user.username
  end

  def cheer_count
    @count ||= self.cheers.count
  end

end
