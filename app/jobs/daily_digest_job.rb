class DailyDigestJob < ApplicationJob
  def perform(*args)
    DailyDigest.new.perform
  end
end
