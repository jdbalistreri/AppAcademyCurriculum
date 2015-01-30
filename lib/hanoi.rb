class Hanoi
  attr_reader :towers
  def initialize(towers = nil)

    @towers = towers || [[3,2,1],[],[]]
  end

  def move(start, finish)
    raise IllegalMoveError.new if @towers[start].empty?
    disc = @towers[start].pop
    @towers[finish].push(disc)
  end


end



class IllegalMoveError < StandardError
end
