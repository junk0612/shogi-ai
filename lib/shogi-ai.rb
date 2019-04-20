module ShogiAI
end

require_relative 'shogi-ai/game'
require_relative 'shogi-ai/board'
require_relative 'shogi-ai/piece'
require_relative 'shogi-ai/move'

ShogiAI::Game.start
