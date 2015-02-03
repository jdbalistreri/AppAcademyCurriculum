require_relative 'index'

class Reply
  extend Table

  def self.table_name
    "replies"
  end

  def self.find_by_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{table_name}.author_id = ?;
    SQL

    results.map{|result| Reply.new(result)}
  end

  attr_accessor :id, :question_id, :parent_id, :author_id, :body

  def initialize(options = {})
    @id    = options['id']
    @question_id = options['question_id']
    @parent_id = options['parent_id']
    @author_id = options['author_id']
    @body = options['body']
  end

end
