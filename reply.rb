require_relative 'index'

class Reply
  extend Table
  extend Writeable

  def self.table_name
    "replies"
  end

  def self.find_by_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{table_name}.question_id = ?;
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

  def author
    User.find_by_id(author_id)
  end

  def question
    Question.find_by_id(question_id)
  end

  def parent_reply
    parent_id && Reply.find_by_id(parent_id)
  end

end
