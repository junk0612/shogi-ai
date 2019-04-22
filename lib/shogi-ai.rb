module ShogiAI
end

require_relative 'shogi-ai/game'
require_relative 'shogi-ai/board'
require_relative 'shogi-ai/piece'
require_relative 'shogi-ai/move'

require_relative 'shogi-ai/move_generator'

ShogiAI::Game.start
