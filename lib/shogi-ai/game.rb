class ShogiAI::Game
  def self.start
    new.play
  end

  def initialize
    @board = ShogiAI::Board.new
    puts @board.to_s
    move = ShogiAI::Move.new('7g7f+', @board)
    puts move.to_s
    @board.apply(move)
    move = ShogiAI::Move.new('7f7e', @board)
    @board.apply(move)
  end

  def play
  end
end
