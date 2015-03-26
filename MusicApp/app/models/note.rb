class Note < ActiveRecord::Base
  validates :user_id, :track_id, :content, presence: true

  belongs_to :user
  belongs_to :track

  def user_email
    user.email
  end

  def user_id
    user.id
  end

end
