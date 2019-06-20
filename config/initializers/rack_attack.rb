# frozen_string_literal: true

class Rack::Attack
  throttle('requests by ip', limit: 60, period: 60) do |request|
    request.ip
  end

  spammers = ENV['ip_blacklist'].to_s.split(/,\s*/)

  unless spammers.empty?
    spammer_regexp = Regexp.union(spammers)
    blocklist('block spammers') do |request|
      request.ip =~ spammer_regexp
    end
  end
end
