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
    SELECT
      c.name, r.continent
    FROM
      (SELECT
        max_pop, neigh_pop, max_pops.continent
      FROM
        (SELECT
          max(population) max_pop, continent
        FROM
          countries
        GROUP BY
          continent) AS max_pops
      JOIN
        (SELECT
          max(population) neigh_pop, continent
        FROM
          countries
        WHERE
          population NOT IN (74900000, 141500000, 1100000000, 1300000000, 295000000, 130200000, 13000000, 182800000)
        GROUP BY
          continent) AS neighbors
      ON max_pops.continent = neighbors.continent) r
    JOIN
      countries c ON r.max_pop = c.population
    WHERE
      r.max_pop > 3 * r.neigh_pop

  SQL
end
