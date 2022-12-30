class NewAnswerDigestJob < ApplicationJob
  def perform(*args)
    DailyDigest.new.perform
  end
end
