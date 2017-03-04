class Transaction < ApplicationRecord
  belongs_to :account

  after_initialize :default_values


  def self.all_statuses ; %w[approved declined pending] ; end

  def self.all_kinds ; %w[deposit withdraw transfer send borrow] ; end

  def default_values
    self.status ||= 'pending'
    self.processed = false
  end

  validates :kind, :presence => true
  validates :kind, :inclusion => {:in => Transaction.all_kinds}
  validates :amount, :presence => true
  validates_numericality_of :amount, :greater_than_or_equal_to => 0
  validates :status, :presence => true
  validates :status, :inclusion => {:in => Transaction.all_statuses}

end
