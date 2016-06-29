class Inbox < ActiveRecord::Base

  include KeyFromName

  has_many :team_inboxes, inverse_of: :inbox
  has_many :teams, through: :team_inboxes, inverse_of: :inboxes
  has_many :items, inverse_of: :inbox

end
