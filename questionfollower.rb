require_relative 'index'

class QuestionFollower
  extend Table

  def self.table_name
    "question_followers"
  end

  def self.followers_for_question_id(question_id)
    users = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        question_followers
      JOIN
        users ON question_followers.follower_id = users.id
      WHERE
        question_followers.question_id = ?;
    SQL

    users.map { |user_info| User.new(user_info) }
  end

  def self.questions_for_follower_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        question_followers
      JOIN
        questions
      ON
        questions.id = question_followers.question_id
      WHERE
        question_followers.follower_id = ?;
    SQL

    questions.map { |question_info| Question.new(question_info) }
  end

  def self.most_followed_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        question_followers
      JOIN
        questions ON question_followers.question_id = questions.id
      GROUP BY
        question_id
      ORDER BY
        COUNT(*) DESC
      LIMIT
        ?
    SQL

    questions.map { |question_info| Question.new(question_info) }

  end

  attr_accessor :id, :question_id, :follower_id

  def initialize(options = {})
    @id    = options['id']
    @question_id = options['question_id']
    @follower_id = options['follower_id']
  end

end
