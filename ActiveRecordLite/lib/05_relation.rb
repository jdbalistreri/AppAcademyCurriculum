require_relative 'db_connection'
require_relative '01_sql_object'
require_relative '04_associatable2'

class Relation

  attr_reader :where_params, :called_on_class

  def initialize(called_on_class)
    @called_on_class = called_on_class
    @where_params = {}
  end

  def evaluate
    result = DBConnection.execute(<<-SQL, where_params.values)
      SELECT
        #{called_on_class.table_name}.*
      FROM
        #{called_on_class.table_name}
      WHERE
        #{make_where_line}
    SQL

    called_on_class.parse_all(result)
  end

  def where(params)
    @where_params.merge!(params)
    self
  end


  def method_missing(method_name, *args, &prc)
    if Array.instance_methods.include?(method_name)
      evaluate.send(method_name, *args, &prc)
    else
      super
    end
  end

  def make_where_line
    cols = called_on_class.columns

    where_params.keys.map do |name|
      raise "unknown attribute '#{name}'" unless cols.include?(name)
      "#{name} = ?"
    end
    .join(" AND ")
  end

end



module RelationMethods
  def where(params)
    Relation.new(self).where(params)
  end
end


class SQLObject
  extend RelationMethods
end

class Cat < SQLObject
  belongs_to :human, foreign_key: :owner_id

  finalize!
end

class Human < SQLObject
  self.table_name = 'humans'

  has_many :cats, foreign_key: :owner_id
  belongs_to :house

  finalize!
end

class House < SQLObject
  has_many :humans

  finalize!
end
