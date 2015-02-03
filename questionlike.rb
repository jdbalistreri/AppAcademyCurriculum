require_relative 'index'

class QuestionLike
  extend Table

  def self.table_name
    "question_likes"
  end

  attr_accessor :id, :liker_id, :question_id

  def initialize(options = {})
    @id    = options['id']
    @liker_id = options['liker_id']
    @question_id = options['question_id']
  end

end
