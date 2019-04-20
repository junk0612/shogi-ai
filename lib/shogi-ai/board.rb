class ShogiAI::Board
  def initialize
    initialize_squares
    setup_pieces
  end

  def piece(x, y)
    @squares[x - 1][y - 1]
  end

  def apply(move)
    @squares[move.from.x - 1][move.from.y - 1] = nil
    @squares[move.to.x - 1][move.to.y - 1] = move.piece
    move.piece.promote if move.promote
  end

  def to_s
    <<~BOARD
      後手: #{@hands[:white].empty? ? 'なし' : @hands[:white].map(&:to_s).join(',')}

        9   8   7   6   5   4   3   2   1
      +---+---+---+---+---+---+---+---+---+
      |#{b(9, 1)}|#{b(8, 1)}|#{b(7, 1)}|#{b(6, 1)}|#{b(5, 1)}|#{b(4, 1)}|#{b(3, 1)}|#{b(2, 1)}|#{b(1, 1)}| 一
      +---+---+---+---+---+---+---+---+---+
      |#{b(9, 2)}|#{b(8, 2)}|#{b(7, 2)}|#{b(6, 2)}|#{b(5, 2)}|#{b(4, 2)}|#{b(3, 2)}|#{b(2, 2)}|#{b(1, 2)}| 二
      +---+---+---+---+---+---+---+---+---+
      |#{b(9, 3)}|#{b(8, 3)}|#{b(7, 3)}|#{b(6, 3)}|#{b(5, 3)}|#{b(4, 3)}|#{b(3, 3)}|#{b(2, 3)}|#{b(1, 3)}| 三
      +---+---+---+---+---+---+---+---+---+
      |#{b(9, 4)}|#{b(8, 4)}|#{b(7, 4)}|#{b(6, 4)}|#{b(5, 4)}|#{b(4, 4)}|#{b(3, 4)}|#{b(2, 4)}|#{b(1, 4)}| 四
      +---+---+---+---+---+---+---+---+---+
      |#{b(9, 5)}|#{b(8, 5)}|#{b(7, 5)}|#{b(6, 5)}|#{b(5, 5)}|#{b(4, 5)}|#{b(3, 5)}|#{b(2, 5)}|#{b(1, 5)}| 五
      +---+---+---+---+---+---+---+---+---+
      |#{b(9, 6)}|#{b(8, 6)}|#{b(7, 6)}|#{b(6, 6)}|#{b(5, 6)}|#{b(4, 6)}|#{b(3, 6)}|#{b(2, 6)}|#{b(1, 6)}| 六
      +---+---+---+---+---+---+---+---+---+
      |#{b(9, 7)}|#{b(8, 7)}|#{b(7, 7)}|#{b(6, 7)}|#{b(5, 7)}|#{b(4, 7)}|#{b(3, 7)}|#{b(2, 7)}|#{b(1, 7)}| 七
      +---+---+---+---+---+---+---+---+---+
      |#{b(9, 8)}|#{b(8, 8)}|#{b(7, 8)}|#{b(6, 8)}|#{b(5, 8)}|#{b(4, 8)}|#{b(3, 8)}|#{b(2, 8)}|#{b(1, 8)}| 八
      +---+---+---+---+---+---+---+---+---+
      |#{b(9, 9)}|#{b(8, 9)}|#{b(7, 9)}|#{b(6, 9)}|#{b(5, 9)}|#{b(4, 9)}|#{b(3, 9)}|#{b(2, 9)}|#{b(1, 9)}| 九
      +---+---+---+---+---+---+---+---+---+

      先手: #{@hands[:black].empty? ? 'なし' : @hands[:black].map(&:to_s).join(',')}
    BOARD
  end

  private

  def initialize_squares
    @squares = [
      [nil, nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil, nil]
    ]
  end

  def setup_pieces
    @hands = {black: [], white: []}
    @squares[0][0] = ShogiAI::Lance.new(black: false)
    @squares[1][0] = ShogiAI::Knight.new(black: false)
    @squares[2][0] = ShogiAI::Silver.new(black: false)
    @squares[3][0] = ShogiAI::Gold.new(black: false)
    @squares[4][0] = ShogiAI::King.new(black: false)
    @squares[5][0] = ShogiAI::Gold.new(black: false)
    @squares[6][0] = ShogiAI::Silver.new(black: false)
    @squares[7][0] = ShogiAI::Knight.new(black: false)
    @squares[8][0] = ShogiAI::Lance.new(black: false)

    @squares[1][1] = ShogiAI::Bishop.new(black: false)
    @squares[7][1] = ShogiAI::Rook.new(black: false)

    @squares[0][2] = ShogiAI::Pawn.new(black: false)
    @squares[1][2] = ShogiAI::Pawn.new(black: false)
    @squares[2][2] = ShogiAI::Pawn.new(black: false)
    @squares[3][2] = ShogiAI::Pawn.new(black: false)
    @squares[4][2] = ShogiAI::Pawn.new(black: false)
    @squares[5][2] = ShogiAI::Pawn.new(black: false)
    @squares[6][2] = ShogiAI::Pawn.new(black: false)
    @squares[7][2] = ShogiAI::Pawn.new(black: false)
    @squares[8][2] = ShogiAI::Pawn.new(black: false)

    @squares[0][6] = ShogiAI::Pawn.new(black: true)
    @squares[1][6] = ShogiAI::Pawn.new(black: true)
    @squares[2][6] = ShogiAI::Pawn.new(black: true)
    @squares[3][6] = ShogiAI::Pawn.new(black: true)
    @squares[4][6] = ShogiAI::Pawn.new(black: true)
    @squares[5][6] = ShogiAI::Pawn.new(black: true)
    @squares[6][6] = ShogiAI::Pawn.new(black: true)
    @squares[7][6] = ShogiAI::Pawn.new(black: true)
    @squares[8][6] = ShogiAI::Pawn.new(black: true)

    @squares[1][7] = ShogiAI::Rook.new(black: true)
    @squares[7][7] = ShogiAI::Bishop.new(black: true)

    @squares[0][8] = ShogiAI::Lance.new(black: true)
    @squares[1][8] = ShogiAI::Knight.new(black: true)
    @squares[2][8] = ShogiAI::Silver.new(black: true)
    @squares[3][8] = ShogiAI::Gold.new(black: true)
    @squares[4][8] = ShogiAI::King.new(black: true)
    @squares[5][8] = ShogiAI::Gold.new(black: true)
    @squares[6][8] = ShogiAI::Silver.new(black: true)
    @squares[7][8] = ShogiAI::Knight.new(black: true)
    @squares[8][8] = ShogiAI::Lance.new(black: true)
  end

  def b(x, y)
    @squares[x - 1][y - 1].nil? ? '   ' : @squares[x - 1][y - 1].to_s
  end
end
