class Membership < ActiveRecord::Base

  default_scope { order('created_at desc') }

  scope :active_members, -> { where('created_at > ?', 1.year.ago) }

  # created_before(1.year.ago)
  scope :created_before, -> (time) { where("created_at < ?", time) }

  def self.default_fee
    logger.debug "HELLLLOOOOO"
    120000
  end
end
