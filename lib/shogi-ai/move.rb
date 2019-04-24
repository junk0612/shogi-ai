class ShogiAI::Move
  class Position
    attr_reader :x
    attr_reader :y

    def initialize(x, y)
      @x = x
      @y = y
    end

    def to_s
      "#{@x}#{@y}"
    end
  end

  attr_reader :from
  attr_reader :to
  attr_reader :piece
  attr_reader :promote

  def initialize(usi_string, board, turn)
    if usi_string[1] != '*'
      from_str = usi_string[0..1]
      to_str = usi_string[2..3]
      from_x = from_str.to_i
      from_y = from_str.codepoints[1] - ?a.ord + 1
      @from = Position.new(from_x, from_y)
      @to = Position.new(to_str.to_i, to_str.codepoints[1] - ?a.ord + 1)
      @piece = board.piece(from_x, from_y)
      @promote = usi_string[4] == '+'
    else
      to_str = usi_string[2..3]
      @from = :hand
      @to = Position.new(to_str.to_i, to_str.codepoints[1] - ?a.ord + 1)
      @piece = board.hand(usi_string[0], turn)
      @promote = false
    end
  end

  def to_s
    from_s =
      if @from == :hand
        '(持ち駒→)'
      else
        "(#{@from}→)"
      end
    "#{from_s}#{@to}#{@piece.to_kanji}#{@promote ? '成' : nil}"
  end
end
