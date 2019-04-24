class ShogiAI::MoveGenerator
  def initialize(board, turn)
    @board = board
    @turn = turn
  end

  def generate
    from_board =
      (1..9).reduce([]) do |acc1, x|
        acc1 + (1..9).reduce([]) do |acc2, y|
          next acc2 if (piece = @board.piece(x, y)).nil? || !piece.friend?(@turn)

          moves = piece.moves(x, y)
          if piece.projective?
            moves =
              moves.reduce([]) do |acc3, i_moves|
                idx = i_moves.find_index {|ix, iy| !@board.piece(ix, iy).nil? }
                acc3 + (idx.nil? ? i_moves : i_moves.first(idx + 1))
              end
          end

          moves.reject! {|ix, iy| (ix < 1 || iy < 1 || ix > 9 || iy > 9) || (!@board.piece(ix, iy).nil? && @board.piece(ix, iy).friend?(@turn)) }
          moves.map! {|ix, iy|
            usi_string = "#{x}#{(y - 1 + ?a.ord).chr}#{ix}#{(iy - 1 + ?a.ord).chr}"
            ary = ((@turn == :black && iy <= 3) || (@turn == :white && iy >= 7)) && piece.promotable? ? [ShogiAI::Move.new("#{usi_string}+", @board, @turn)] : []
            ary + [ShogiAI::Move.new(usi_string, @board, @turn)]
          }.flatten!

          acc2 + moves
        end
      end

    blank =
      (1..9).reduce([]) {|acc1, x|
        acc1 <<
          (1..9).select {|y| @board.piece(x, y).nil? }.map {|y| [x, y] } +
          [(1..9).any? {|y| !(piece = @board.piece(x, y)).nil? && piece.friend?(@turn) && piece.is_a?(ShogiAI::Pawn) }]
    }

    from_hand = blank.map {|array|
      friend_fu_present = array.last
      array[0..-2].map {|x, y|
        @board.hands[@turn].map {|piece|
          next if piece.is_a?(ShogiAI::Pawn) && friend_fu_present

          usi_string = "#{piece.to_char}*#{x}#{(y - 1 + ?a.ord).chr}"
          ShogiAI::Move.new(usi_string, @board, @turn)
        }.compact
      }.flatten
    }.flatten

    from_board + from_hand
  end
end
