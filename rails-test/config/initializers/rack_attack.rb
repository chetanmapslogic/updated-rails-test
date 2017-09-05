class Rack::Attack
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new 
 

  whitelist('') do |req|
  	tenant = Tenant.find_by_api_key(req["api_key"])
		request_count = tenant.activity_logs.where('DATE(created_at) = ?', Date.today).count
		if request_count > 100
		  throttle('api/ip', limit: 1, period: 10) do |req|
		    req.ip if req.subdomain == 'api'
		  end
		end
	end

  class Request < ::Rack::Request
    def subdomain
      host.split('.').first
    end
  end
end