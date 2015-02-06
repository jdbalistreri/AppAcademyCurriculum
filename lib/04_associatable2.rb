require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    human_options = assoc_options[through_name]
    house_options = human_options.model_class.assoc_options[source_name]

    define_method("#{name}") do
      result = DBConnection.execute(<<-SQL, owner_id: owner_id)
        SELECT
          #{house_options.table_name}.*
        FROM
          #{human_options.table_name}
        JOIN
          #{house_options.table_name}
        ON
          #{human_options.table_name}.#{house_options.foreign_key} =
            #{house_options.table_name}.#{house_options.primary_key}
        WHERE
          #{human_options.table_name}.#{human_options.primary_key}
            = :owner_id
      SQL


      house_options.model_class.parse_all(result).first
    end
  end
end
