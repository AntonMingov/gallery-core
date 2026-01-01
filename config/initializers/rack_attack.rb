Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

Rack::Attack.throttle('contacts/ip', limit: 5, period: 1.hour) do |req|
  req.ip if req.path.match?(%r{/(en|bg)?/contacts}) && req.post?
end

Rack::Attack.throttle('contacts/email', limit: 3, period: 1.hour) do |req|
  if req.path.match?(%r{/(en|bg)?/contacts}) && req.post?
    req.params['contact']&.dig('email')
  end
end

Rack::Attack.throttled_response = lambda do |env|
  match_data = env['rack.attack.match_data']
  now = match_data[:epoch_time]

  headers = {
    'X-RateLimit-Limit' => match_data[:limit].to_s,
    'X-RateLimit-Remaining' => '0',
    'X-RateLimit-Reset' => (now + (match_data[:period] - (now % match_data[:period]))).to_s,
    'Content-Type' => 'application/json'
  }

  [429, headers, [{ error: 'Too many requests. Please try again later.' }.to_json]]
end

