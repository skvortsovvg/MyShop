class NewAnswerDigest
  include Delayed::RecurringJob

  def perform(answer)
    send_digest(answer)
  end 

private
  
  def send_digest(answer)
    NewAnswerDigestMailer.digest(answer).deliver_later
  end
  
end