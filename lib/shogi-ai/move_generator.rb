class ShogiAI::MoveGenerator
  def initialize(board, turn)
    @board = board
    @turn = turn
  end

  def generate
    (1..9).reduce([]) do |acc1, x|
      acc1 << (1..9).reduce([]) do |acc2, y|
        next acc2 if (piece = @board.piece(x, y)).nil? || !piece.friend?(@turn)

        moves = piece.moves(x, y)
        if piece.projective?
          moves.map! do |i_moves|
            idx = i_moves.find_index {|ix, iy| !@board.piece(ix, iy).nil? }
            idx.nil? ? i_moves : i_moves.first(idx + 1)
          end
        end

        acc2 << moves
      end
    end
  end
end
