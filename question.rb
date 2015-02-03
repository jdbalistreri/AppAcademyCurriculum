require_relative 'index'

class Question
  extend Table
  extend Writeable

  def self.table_name
    "questions"
  end

  attr_accessor :id, :title, :body, :author_id

  def initialize(options = {})
    @id    = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def author
    User.find_by_id(author_id)
  end
end
