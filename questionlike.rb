require_relative 'index'

class QuestionLike
  extend Table

  def self.table_name
    "question_likes"
  end

  def self.likers_for_question_id(question_id)
    likers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        question_likes
      JOIN
        users ON question_likes.liker_id = users.id
      WHERE
        question_likes.question_id = ?
    SQL

    likers.map { |liker_info| User.new(liker_info) }
  end

  def self.num_likes_for_question_id(question_id)
    count_array = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(*)
      FROM
        question_likes
      JOIN
        users ON question_likes.liker_id = users.id
      WHERE
        question_likes.question_id = ?
    SQL

    count_array.first['COUNT(*)']
  end

  def self.liked_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        question_likes
      JOIN
        questions ON question_likes.question_id = questions.id
      WHERE
        question_likes.liker_id = ?
    SQL

    questions.map { |question_info| Question.new(question_info) }
  end

  attr_accessor :id, :liker_id, :question_id

  def initialize(options = {})
    @id    = options['id']
    @liker_id = options['liker_id']
    @question_id = options['question_id']
  end

end
