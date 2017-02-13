class Transaction < ApplicationRecord
  belongs_to :account

  after_initialize :default_values

  after_create :disposition

  def self.all_statuses ; %w[approved declined pending] ; end

  def self.all_kinds ; %w[deposit withdraw send borrow] ; end

  def default_values
    if (self.kind == 'withdraw' && self.amount < 1000) || self.kind == 'send' || self.kind == 'borrow'
      self.status ||= 'approved'
    else
      self.status ||= 'pending'
    end
    self.start_date = self.created_at
  end

  def disposition
    if (self.kind == 'withdraw' && self.amount > 1000) || self.kind == 'send' || self.kind == 'borrow'
      self.status ||= 'approved'
    end
    self.start_date = self.created_at
  end

  validates :kind, :presence => true
  validates :kind, :inclusion => {:in => Transaction.all_kinds}
  validates :amount, :presence => true
  validates :status, :presence => true
  validates :status, :inclusion => {:in => Transaction.all_statuses}

end
