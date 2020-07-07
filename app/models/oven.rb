class Oven < ActiveRecord::Base
  belongs_to :user
  has_one :cookies, as: :storage

  validates :user, presence: true
end
