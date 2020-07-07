class OvenChannel < ApplicationCable::Channel
  def subscribed
    stream_from "oven_#{params['oven_id']}_channel"
  end

  def unsubscribed; end

  def send_data(data)
  end
end