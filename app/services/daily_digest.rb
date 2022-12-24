class DailyDigest
  include Delayed::RecurringJob
  run_every 1.day

  def perform
    send_digest
  end 

private

  def send_digest
    User.find_each(batch_size: 500) do |user|
      DailyDigestMailer.digest(user).deliver_later
    end
  end
end