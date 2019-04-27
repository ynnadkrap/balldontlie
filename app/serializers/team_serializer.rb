# frozen_string_literal: true

class TeamSerializer < Blueprinter::Base
  identifier :id do |object|
    object.public_id
  end

  fields :conference,
         :division,
         :city,
         :abbreviation,
         :name,
         :full_name
end
