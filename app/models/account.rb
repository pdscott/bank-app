class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions

  after_initialize :default_values

  def self.all_statuses ; %w[active closed pending N/A] ; end

  def default_values
    self.status ||= 'pending'
    self.balance ||= 0.0
  end

  validates :status, :presence => true
  validates :status, :inclusion => {:in => Account.all_statuses}
  validates :balance, :presence => true

end
