class Connection < ApplicationRecord
  after_initialize :default_values

  def self.all_statuses ; %w[pending rejected accepted] ; end


  def default_values
    self.status ||= 'pending'
  end

  validates :status, :presence => true
  validates :status, :inclusion => {:in => Connection.all_statuses}
  validates :sender, :presence => true
  validates :recipient, :presence => true

end
