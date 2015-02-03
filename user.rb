require_relative 'index'

class User
  extend Table

  def self.table_name
    "users"
  end

  def self.find_by_name(fname, lname)
    results = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{table_name}.fname = ? AND #{table_name}.lname = ?;
    SQL

    self.new(results.first)
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

end
