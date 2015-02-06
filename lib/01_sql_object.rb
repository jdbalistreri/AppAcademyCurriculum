require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # ...
  end

  def self.finalize!
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || self.to_s.tableize
  end

  def self.all
    # returns an array of all the records in the DB
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # look up a single record by a primary key
  end

  def initialize(params = {})
    # ...
  end

  def attributes
    # ...
  end

  def attribute_values
    # ...
  end

  def insert
    # insert a new row into the table to represent the SQLObject
  end

  def update
    # update the row with the id of this SQLObject
  end

  def save
    # a convenience method calling either insert or update
  end
end
