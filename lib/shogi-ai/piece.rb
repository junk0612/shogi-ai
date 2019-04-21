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
  end

  class Pawn < Piece
    def to_kanji
      @promoted ? 'と' : '歩'
    end

    def sort_order
      1
    end
  end

  class Lance < Piece
    def to_kanji
      @promoted ? '杏' : '香'
    end

    def sort_order
      2
    end
  end

  class Knight < Piece
    def to_kanji
      @promoted ? '圭' : '桂'
    end

    def sort_order
      3
    end
  end

  class Silver < Piece
    def to_kanji
      @promoted ? '全' : '銀'
    end

    def sort_order
      4
    end
  end

  class Gold < Piece
    def to_kanji
      '金' unless @promoted
    end

    def sort_order
      5
    end
  end

  class Bishop < Piece
    def to_kanji
      @promoted ? '馬' : '角'
    end

    def sort_order
      6
    end
  end

  class Rook < Piece
    def to_kanji
      @promoted ? '龍' : '飛'
    end

    def sort_order
      7
    end
  end

  class King < Piece
    def to_kanji
      '玉' unless @promoted
    end

    def sort_order
      8
    end
  end
end
