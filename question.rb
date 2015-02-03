require_relative 'index'

class Question
  extend Table

  def self.table_name
    "questions"
  end

  def self.find_by_author(author_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{table_name}.author_id = ?
    SQL

    results.map{|result| Question.new(result)}
  end

  attr_accessor :id, :title, :body, :author_id

  def initialize(options = {})
    @id    = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def author
    results = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        #{User.table_name}
      WHERE
        #{User.table_name}.id = #{author_id}
    SQL

    User.new(results.first)
  end
end
