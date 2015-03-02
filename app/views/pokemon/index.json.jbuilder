
json.array! @pokemon do |poke|
  json.partial! 'pokemon/pokemon', pokemon: poke
end
