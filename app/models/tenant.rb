class Tenant < ActiveRecord::Base

  before_create :generate_api_key

  has_many :request_logs

  def log_request(search_term)
    self.update_attributes!(request_count: self.request_count + 1)
    RequestLog.create(tenant_id: self.id, search_term: search_term)
  end

  def should_throttle?
    self.request_logs.where("created_at > ?", Date.today.beginning_of_day).count > 100 && self.request_logs.last.created_at > Time.now - 10.seconds
  end

  private

  def generate_api_key
    self.api_key = SecureRandom.hex(16)
  end

end
