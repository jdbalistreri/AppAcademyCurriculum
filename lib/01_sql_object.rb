require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    all = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
      LIMIT
        1
    SQL

    all.first.map(&:to_sym)
  end

  def self.finalize!
    columns.each do |name|
      make_getter(name)
      make_setter(name)
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || self.to_s.tableize
  end

  def self.all
    results = DBConnection.execute(<<-SQL)
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
    SQL

    parse_all(results)
  end

  def self.parse_all(results)
    results.map { |params| self.new(params) }
  end

  def self.find(id)
    result = DBConnection.execute(<<-SQL, id: id)
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
      WHERE
        id = :id
    SQL

    parse_all(result).first
  end

  def initialize(params = {})
    self.class.finalize!

    columns = self.class.columns

    params.each do |attr_name, value|
      attr_name = attr_name.to_sym
      raise "unknown attribute '#{attr_name}'" unless columns.include?(attr_name)

      self.send("#{attr_name}=", value)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map { |attr_name| self.send("#{attr_name}") }
  end

  def insert
    columns         = self.class.columns.drop(1)
    question_marks  = (["?"]*columns.count).join(", ")
    column_names    = columns.join(", ")

    attrs_without_id = attribute_values.drop(1)

    DBConnection.execute(<<-SQL, attrs_without_id)
      INSERT INTO
        #{self.class.table_name} (#{column_names})
      VALUES
        (#{question_marks})
    SQL

    self.send("id=", DBConnection.last_insert_row_id)
  end

  def update
    columns = self.class.columns.drop(1)
    attrs = attribute_values
    attrs << attrs.shift

    set_line = columns.map{ |name| "#{name} = ?" }.join(", ")

    DBConnection.execute(<<-SQL, attrs)
      UPDATE
        #{self.class.table_name}
      SET
        #{set_line}
      WHERE
        id = ?
    SQL
  end

  def save
    id.nil? ? insert : update
  end

  private
    def self.make_getter(name)
      define_method("#{name}") do
        attributes[name]
      end
    end

    def self.make_setter(name)
      define_method("#{name}=") do |value|
        attributes[name] = value
      end
    end
end
