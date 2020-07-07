module Cookies
  class CookieWorker
    include Sidekiq::Worker

    def perform(id)
      Cookie.find(id).cook!
    end
  end
end