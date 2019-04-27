# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :players
end
