class Init < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :conference, null: false
      t.string :division, null: false
      t.string :city, null: false
      t.string :abbreviation, null: false
      t.string :name, null: false
      t.string :full_name, null: false
    end

    create_table :games do |t|
      t.date :date, null: false
      t.bigint :home_team_id, index: true, null: false
      t.bigint :visitor_team_id, index: true, null: false
      t.integer :season, null: false
    end

    add_foreign_key :games, :teams, column: :home_team_id
    add_foreign_key :games, :teams, column: :visitor_team_id

    create_table :players do |t|
      t.text :first_name, null: false
      t.text :last_name, null: false
      t.string :position, null: false
      t.bigint :team_id, null: false, index: true, foreign_key: true
    end

    create_table :player_stats do |t|
      t.bigint :team_id, null: false, index: true, foreign_key: true
      t.bigint :game_id, null: false, index: true, foreign_key: true
      t.bigint :player_id, null: false, index: true, foreign_key: true
      t.string :min
      t.integer :fgm
      t.integer :fga
      t.numeric :fg_pct
      t.integer :fg3m
      t.integer :fg3a
      t.numeric :fg3_pct
      t.integer :ftm
      t.integer :fta
      t.numeric :ft_pct
      t.integer :oreb
      t.integer :dreb
      t.integer :reb
      t.integer :ast
      t.integer :stl
      t.integer :blk
      t.integer :turnover
      t.integer :pf
      t.integer :pts
    end
  end
end
