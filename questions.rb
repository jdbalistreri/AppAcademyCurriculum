require 'singleton'
require 'sqlite3'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.results_as_hash = true
    self.type_translation = true
  end
end

module Table
  def find_by_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{table_name}.id = ?;
    SQL

    self.new(results.first)
  end

end

class User
  extend Table

  def self.table_name
    "users"
  end

  def initialize(options = {})
    @id    = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

end


class Question
  extend Table

  def self.table_name
    "questions"
  end

  def initialize(options = {})
    @id    = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end
end

class QuestionFollower
  extend Table

  def self.table_name
    "question_followers"
  end

  def initialize(options = {})
    @id    = options['id']
    @question_id = options['question_id']
    @follower_id = options['follower_id']
  end

end

class Reply
  extend Table

  def self.table_name
    "replies"
  end

  def initialize(options = {})
    @id    = options['id']
    @question_id = options['question_id']
    @parent_id = options['parent_id']
    @body = options['body']
  end

end

class QuestionLike
  extend Table

  def self.table_name
    "question_likes"
  end

  def initialize(options = {})
    @id    = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

end
