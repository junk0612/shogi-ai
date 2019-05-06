class ShogiAI::Game
  def self.start
    new.play
  end

  def initialize
    @board = ShogiAI::Board.new
    @turn = :black
    @brain = ShogiAI::Brain.new
  end

  def play
    puts @board
    until ended?
      get_move_and_apply
      @turn = @turn == :black ? :white : :black
    end
  end

  private

  def get_move_and_apply
    moves = ShogiAI::MoveGenerator.new(@board, @turn).generate
    move = @brain.select(moves)
    puts move.to_s
    @board.apply(move)
  end

  def ended?
    @board.black_king_captured? || @board.white_king_captured?
  end
end
