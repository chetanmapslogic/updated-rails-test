class Tenant < ActiveRecord::Base
  before_create :generate_api_key
	has_many :activity_logs
  
  private

  def generate_api_key
    self.api_key = SecureRandom.hex(16)
  end

end
