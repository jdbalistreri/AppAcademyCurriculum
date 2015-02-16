class Goal < ActiveRecord::Base
  include Commentable
  
  validates :title, :description, :user, :privacy, presence: true
  enum privacy: [ :open, :closed ]

  belongs_to :user, inverse_of: :goals

  def user_name
    user.username
  end

end
