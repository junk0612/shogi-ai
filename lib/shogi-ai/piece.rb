module ShogiAI
  class Piece
    attr_accessor :black

    def initialize(black: true)
      @promoted = false
      @black = black
    end

    def promote
      @promoted = true
    end

    def demote
      @promoted = false
    end

    def to_s
      "#{@black ? '^' : 'v'}#{to_kanji}"
    end

    def moves(x, y)
      []
    end

    def projective?
      false
    end

    def friend?(turn)
      if turn == :black
        @black
      else
        !@black
      end
    end
  end

  class Pawn < Piece
    def to_kanji
      @promoted ? 'と' : '歩'
    end

    def to_char
      'P'
    end

    def sort_order
      1
    end

    def moves(x, y)
      [[x, y + (@black ? -1 : 1)]]
    end

    def projective?
      false
    end
  end

  class Lance < Piece
    def to_kanji
      @promoted ? '杏' : '香'
    end

    def to_char
      'L'
    end

    def sort_order
      2
    end

    def moves(x, y)
      [
        if @black
          (y - 1).downto(1).map {|y2|
            [x, y2]
          }
        else
          (y + 1).upto(9).map {|y2|
            [x, y2]
          }
        end
      ]
    end

    def projective?
      true
    end
  end

  class Knight < Piece
    def to_kanji
      @promoted ? '圭' : '桂'
    end

    def to_char
      'N'
    end

    def sort_order
      3
    end

    def moves(x, y)
      y2 = @black ? y - 2 : y + 2
      [[x - 1, y2], [x + 1, y2]]
    end

    def projective?
      false
    end
  end

  class Silver < Piece
    def to_kanji
      @promoted ? '全' : '銀'
    end

    def to_char
      'S'
    end

    def sort_order
      4
    end

    def moves(x, y)
      [
        [x - 1, y - 1],
        [x + 1, y - 1],
        [x - 1, y + 1],
        [x + 1, y + 1],
        [x, @black ? y - 1 : y + 1]
      ]
    end

    def projective?
      false
    end
  end

  class Gold < Piece
    def to_kanji
      '金' unless @promoted
    end

    def to_char
      'G'
    end

    def sort_order
      5
    end

    def moves(x, y)
      [
        [x - 1, y],
        [x, y - 1],
        [x + 1, y],
        [x, y + 1],
        [x - 1, @black ? y - 1 : y + 1],
        [x + 1, @black ? y - 1 : y + 1]
      ]
    end

    def projective?
      false
    end
  end

  class Bishop < Piece
    def to_kanji
      @promoted ? '馬' : '角'
    end

    def to_char
      'B'
    end

    def sort_order
      6
    end

    def moves(x, y)
      [
        (1..[9 - x, y - 1].min).map {|i| [x + i, y - i] },
        (1..[x - 1, y - 1].min).map {|i| [x - i, y - i] },
        (1..[x - 1, 9 - y].min).map {|i| [x - i, y + i] },
        (1..[9 - x, 9 - y].min).map {|i| [x + i, y + i] }
      ]
    end

    def projective?
      true
    end
  end

  class Rook < Piece
    def to_kanji
      @promoted ? '龍' : '飛'
    end

    def to_char
      'R'
    end

    def sort_order
      7
    end

    def moves(x, y)
      [
        (y - 1).downto(1).map {|i| [x, i] },
        (x - 1).downto(1).map {|i| [i, y] },
        (y + 1).upto(9).map {|i| [x, i] },
        (x + 1).upto(9).map {|i| [i, y] }
      ]
    end

    def projective?
      true
    end
  end

  class King < Piece
    def to_kanji
      '玉' unless @promoted
    end

    def to_char
      'K'
    end

    def sort_order
      8
    end

    def moves(x, y)
      [
        [x - 1, y - 1],
        [x, y - 1],
        [x + 1, y - 1],
        [x + 1, y],
        [x + 1, y + 1],
        [x, y + 1],
        [x - 1, y + 1],
        [x - 1, y]
      ]
    end

    def projective?
      false
    end
  end
end
