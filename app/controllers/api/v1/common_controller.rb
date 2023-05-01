class Api::V1::CommonController < ApplicationController
  skip_before_action :verify_authenticity_token
  def report
    Payment.create(payload: request.body.string, signature: request.headers["Signature"])
    render json: Payment.last.payload
  end
  def reports
    # How to - https://ru.hexlet.io/qna/ruby/questions/kak-preobrazovat-stroku-v-hesh-ruby
    render json: Payment.all.map { |pay| { data: JSON.parse(pay.payload)["order"], signature: pay.signature } } 
  end
end
