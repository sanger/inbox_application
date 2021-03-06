class TeamInbox < ApplicationRecord
  belongs_to :team, inverse_of: :team_inboxes
  belongs_to :inbox, inverse_of: :team_inboxes

  validates :order, presence: true
  validates_uniqueness_of :order, scope: :team

  validates :team, presence: true
  validates :inbox, presence: true

  delegate :name, :key, :status, to: :inbox

  def key=(key)
    self.inbox = Inbox.where(key:key).first
  end

end
