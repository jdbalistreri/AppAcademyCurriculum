class Cheer < ActiveRecord::Base
  validates :user, :goal, presence: true

  belongs_to :user,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id,
    inverse_of: :cheers

  belongs_to :goal,
    class_name: "Goal",
    primary_key: :id,
    foreign_key: :goal_id,
    inverse_of: :cheers
    
end
