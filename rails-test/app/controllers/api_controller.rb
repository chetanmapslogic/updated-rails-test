class ApiController < ActionController::Base
  def record_activity(note)
    activity = ActivityLog.new
    tenant_id = Tenant.find_by_api_key(params[:api_key]).id
    activity.tenant_id = tenant_id
    activity.save
	end
end
