class Api::V1::CommonController < ApplicationController
  skip_before_action :verify_authenticity_token
  def report
    Payment.create(payload: request.body.string)
    render json: Payment.last.payload
  end
  def reports
    render json: Payment.all.map { |pay| pay.payload }.join(",") 
  end
end