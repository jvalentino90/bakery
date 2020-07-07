module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :user

    def connect
      self.user = find_verified_user
    end

    protected

    def find_verified_user
      if (verified_user = env['warden'].user).present?
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
