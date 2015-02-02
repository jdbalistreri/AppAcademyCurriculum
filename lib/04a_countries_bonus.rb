# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

# BONUS QUESTIONS: These problems require knowledge of aggregate
# functions. Attempt them after completing section 05.

def highest_gdp
  # Which countries have a GDP greater than every country in Europe? (Give the
  # name only. Some countries may have NULL gdp values)
  execute(<<-SQL)
    SELECT
      name
    FROM
      countries
    WHERE
      gdp > (
        SELECT
          MAX(gdp)
        FROM
          countries
        WHERE
          continent = 'Europe'
      )
  SQL
end

def largest_in_continent
  # Find the largest country (by area) in each continent. Show the continent,
  # name, and area.
  execute(<<-SQL)
    SELECT
      max_areas.continent, c2.name, max_areas.area
    FROM
      (SELECT
        c1.continent, max(c1.area) area
      FROM
        countries c1
      GROUP BY
        c1.continent) AS max_areas
    JOIN
      countries c2 ON max_areas.continent = c2.continent AND
        max_areas.area = c2.area
  SQL
end

def large_neighbors
  # Some countries have populations more than three times that of any of their
  # neighbors (in the same continent). Give the countries and continents.
  execute(<<-SQL)
    -- SELECT
    --   continent, name, area
    -- FROM
    --   countries
    -- ORDER BY
    --   continent, area DESC
    -- GROUP BY
    --   continent`

  SQL
end
