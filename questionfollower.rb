require_relative 'index'

class QuestionFollower
  extend Table

  def self.table_name
    "question_followers"
  end

  attr_accessor :id, :question_id, :follower_id

  def initialize(options = {})
    @id    = options['id']
    @question_id = options['question_id']
    @follower_id = options['follower_id']
  end

end
