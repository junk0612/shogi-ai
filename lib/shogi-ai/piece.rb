module ShogiAI
  class Piece
    def initialize(black: true)
      @promoted = false
      @black = black
    end

    def promote
      @promoted = true
    end

    def to_s
      "#{@black ? '^' : 'v'}#{to_kanji}"
    end
  end

  class Pawn < Piece
    def to_kanji
      @promoted ? 'と' : '歩'
    end
  end

  class Lance < Piece
    def to_kanji
      @promoted ? '杏' : '香'
    end
  end

  class Knight < Piece
    def to_kanji
      @promoted ? '圭' : '桂'
    end
  end

  class Silver < Piece
    def to_kanji
      @promoted ? '全' : '銀'
    end
  end

  class Gold < Piece
    def to_kanji
      '金' unless @promoted
    end
  end

  class Bishop < Piece
    def to_kanji
      @promoted ? '馬' : '角'
    end
  end

  class Rook < Piece
    def to_kanji
      @promoted ? '龍' : '飛'
    end
  end

  class King < Piece
    def to_kanji
      '玉' unless @promoted
    end
  end
end
