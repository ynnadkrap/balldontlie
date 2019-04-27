# frozen_string_literal: true

class PlayerStat < ApplicationRecord
  belongs_to :game
  belongs_to :team
  belongs_to :player
end
