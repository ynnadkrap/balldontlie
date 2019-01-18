class ConvertDecimalToReal < ActiveRecord::Migration[5.1]
  def change
    add_column :player_stats, :fg_pct_tmp, :real
    add_column :player_stats, :fg3_pct_tmp, :real
    add_column :player_stats, :ft_pct_tmp, :real

    ActiveRecord::Base.connection.execute <<~SQL
      update player_stats
      set fg_pct_tmp = fg_pct,
      fg3_pct_tmp = fg3_pct,
      ft_pct_tmp = ft_pct
    SQL

    remove_column :player_stats, :fg_pct
    remove_column :player_stats, :fg3_pct
    remove_column :player_stats, :ft_pct

    rename_column :player_stats, :fg_pct_tmp, :fg_pct
    rename_column :player_stats, :fg3_pct_tmp, :fg3_pct
    rename_column :player_stats, :ft_pct_tmp, :ft_pct
  end
end
