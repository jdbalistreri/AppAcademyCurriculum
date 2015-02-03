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
    instances = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{table_name}.id = ?;
    SQL

    self.new(instances.first)
  end
end

module Writeable
  def find_by_author(author_id)
    writables = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{table_name}.author_id = ?;
    SQL

    writables.map{|info| self.new(info)}
  end

end
