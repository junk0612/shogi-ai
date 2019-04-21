class ShogiAI::Game
  def self.start
    new.play
  end

  def initialize
    @board = ShogiAI::Board.new
  end

  def play
    puts @board
    until ended?
      get_move_and_apply
    end
  end

  private

  def get_move_and_apply
    move = ShogiAI::Move.new(gets, @board)
    puts move.to_s
    @board.apply(move)
    puts @board
  end

  def ended?
    @board.black_king_captured? || @board.white_king_captured?
  end
end
