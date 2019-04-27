# frozen_string_literal: true

class SeasonAverageSerializer
  attr_reader :data

  def initialize(data: [])
    @data = data
  end

  def serialize
    data.map do |stats|
      stats.merge(
        'min' => min(stats),
        'fg_pct' => pct(stats, 'fgm', 'fga'),
        'fg3_pct' => pct(stats, 'fg3m', 'fg3a'),
        'ft_pct' => pct(stats, 'ftm', 'fta'),
        'fga' => stats['fga'].to_f.round(2),
        'fgm' => stats['fgm'].to_f.round(2),
        'fg3a' => stats['fg3a'].to_f.round(2),
        'fg3m' => stats['fg3m'].to_f.round(2),
        'fta' => stats['fta'].to_f.round(2),
        'ftm' => stats['ftm'].to_f.round(2)
      )
    end
  end

  private

  def min(stats)
    min = stats['min']
    min = min.sub('{', '')
    min = min.sub('}', '')
    min_arr = min.split(',')

    sec = min_arr.reduce(0) do |sum, time|
      m, s = time.split(':')
      sum += s.to_i
      sum + (m.to_i * 60)
    end

    avg_sec = sec / stats['games_played']
    min = avg_sec / 60
    sec = avg_sec % 60
    sec = sec < 10 ? "0#{sec}" : sec

    "#{min}:#{sec}"
  end

  def pct(stats, num, den)
    return 0 if stats[den].zero?

    (stats[num].to_f / stats[den].to_f).round(3)
  end
end
