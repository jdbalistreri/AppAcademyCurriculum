require_relative 'index'

class QuestionFollower
  extend Table

  def self.table_name
    "question_followers"
  end

  def self.followers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.id, users.fname, users.lname
      FROM
        question_followers
      JOIN
        users ON question_followers.follower_id = users.id
      WHERE
        question_followers.question_id = ?;
    SQL

    results.map { |user_info| User.new(user_info) }
  end

  def self.questions_for_follower_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.id, questions.title, questions.body, questions.author_id
      FROM
        question_followers
      JOIN
        questions
      ON
        questions.id = question_followers.question_id
      WHERE
        question_followers.follower_id = ?;
    SQL

    results.map { |question_info| Question.new(question_info) }
  end

  attr_accessor :id, :question_id, :follower_id

  def initialize(options = {})
    @id    = options['id']
    @question_id = options['question_id']
    @follower_id = options['follower_id']
  end

end


#
# results = QuestionsDatabase.instance.execute(<<-SQL, id)
#   SELECT
#     *
#   FROM
#     #{table_name}
#   WHERE
#     #{table_name}.id = ?;
# SQL
#
# self.new(results.first)
