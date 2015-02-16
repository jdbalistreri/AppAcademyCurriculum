class Goal < ActiveRecord::Base
  validates :title, :description, :user, :privacy, presence: true
  enum privacy: [ :open, :closed ]

  belongs_to :user,
    inverse_of: :goals
end
