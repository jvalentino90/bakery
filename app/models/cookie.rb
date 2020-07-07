class Cookie < ActiveRecord::Base
  include AASM

  aasm column: 'state' do
    state :created, initial: true
    state :cooked

    event :cook do
      transitions from: :created, to: :cooked
    end
  end

  belongs_to :storage, polymorphic: :true

  validates :storage, presence: true

  after_commit :bake, on: :create

  alias_method :ready?, :cooked?

  private

  def bake
    ::Cookies::CookieWorker.perform_in(1.minute, id)
  end
end
