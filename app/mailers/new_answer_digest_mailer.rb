class NewAnswerDigestMailer < ApplicationMailer
  def digest(answer)
    @answer = answer
    mail to: answer.author.email
  end
end
