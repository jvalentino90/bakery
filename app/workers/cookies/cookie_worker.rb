module Cookies
  class CookieWorker
    include Sidekiq::Worker

    def perform(id)
      @cookie = Cookie.find(id)
      @cookie.cook!
      broadcast
    end

    private

    def broadcast
      ActionCable.server.broadcast "oven_#{@cookie.storage.id}_channel", message: {
        oven_id: @cookie.storage.id,
        cookie_id: @cookie.id,
        ready: true
      }
    end
  end
end
