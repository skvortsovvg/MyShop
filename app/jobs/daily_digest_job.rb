class DailyDigestJob < ApplicationJob
  def perform(*args)
    DailyDigest.new.send_digest
  end
end
