require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    cols = self.columns

    where_line = params.keys.map do |name|
      raise "unknown attribute '#{name}'" unless cols.include?(name)
      "#{name} = ?"
    end
    .join("AND ")

    attr_values = params.values

    result = DBConnection.execute(<<-SQL, *attr_values)
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
      WHERE
        #{where_line}
    SQL

    parse_all(result)
  end
end

class SQLObject
  # extend Searchable
end
