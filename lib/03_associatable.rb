require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @foreign_key = options[:foreign_key] ||
                    "#{name.to_s.underscore.singularize}_id".to_sym
    @class_name  = options[:class_name]  ||
                    name.to_s.camelcase.singularize
    @primary_key = options[:primary_key] || :id
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @foreign_key = options[:foreign_key] ||
                     "#{self_class_name.to_s.underscore.singularize}_id".to_sym
    @class_name = options[:class_name]  ||
                    name.to_s.camelcase.singularize
    @primary_key = options[:primary_key] || :id
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name, options)

    define_method("#{name}") do

      result = DBConnection.execute(<<-SQL, id: id)
        SELECT
          #{options.table_name}.*
        FROM
          #{self.class.table_name}
        JOIN
          #{options.table_name}
        ON
          #{options.table_name}.#{options.primary_key} =
          #{self.class.table_name}.#{options.foreign_key}
        WHERE
          #{self.class.table_name}.id = :id
      SQL

      options.model_class.parse_all(result).first
    end
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name, self.to_s, options)

    define_method("#{name}") do

      result = DBConnection.execute(<<-SQL, id: id)
        SELECT
          #{options.table_name}.*
        FROM
          #{self.class.table_name}
        JOIN
          #{options.table_name}
        ON
          #{options.table_name}.#{options.foreign_key} =
          #{self.class.table_name}.#{options.primary_key}
        WHERE
          #{self.class.table_name}.id = :id
      SQL

      options.model_class.parse_all(result)
    end
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  extend Associatable
end
