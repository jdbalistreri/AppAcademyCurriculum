# write some jbuilder to return some json about a board
# it should include the board
#  - its lists
#    - the cards for each list

json.(@board, :id, :title, :updated_at, :created_at)

json.lists @board.lists do |list|
  json.(list, :id, :title, :ord)
  json.cards list.cards, :id, :title, :ord, :description, :list_id
end
