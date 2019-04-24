# frozen_string_literal: true

class Api::V1::SeasonAveragesController < ApplicationController
  def index
    render json: SeasonAverageQuery.new(params: params.to_unsafe_h).averages
  end
end
