require_relative 'index'

class User
  extend Table

  def self.table_name
    "users"
  end

  def self.find_by_name(fname, lname)
    users = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{table_name}.fname = ? AND #{table_name}.lname = ?;
    SQL

    self.new(users.first)
  end

  def self.karma_for_user_id(user_id)
    karma_array = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      CAST(num_likes AS FLOAT) / CAST(num_questions AS FLOAT) karma
    FROM
      (SELECT
        COUNT(question_likes.id) num_likes,
        COUNT(DISTINCT questions.id) num_questions,
        users.id user_id
      FROM
        users
      LEFT OUTER JOIN
        questions ON questions.author_id = ?
      LEFT OUTER JOIN
        question_likes ON question_likes.question_id = questions.id
      GROUP BY
        users.id);
    SQL

    karma_array.first['karma'] || 0

  end

  attr_accessor :id, :fname, :lname

  def initialize(options = {})
    @id    = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions
    Question.find_by_author(id)
  end

  def authored_replies
    Reply.find_by_user_id(id)
  end

  def followed_questions
    QuestionFollower.questions_for_follower_id(id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(id)
  end

  def average_karma
    User.karma_for_user_id(id)
  end

  def save
    if #not saved
      QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
        INSERT INTO
          users (fname, lname)
        VALUES
          (?, ?)
      SQL
    else #update
      QuestionsDatabase.instance.execute(<<-SQL, fname, lname, id)
        UPDATE
          users
        SET
          fname = ?, lname = ?
        WHERE
          id = ?;
    end
  end

end
