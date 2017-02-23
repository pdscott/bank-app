require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  test "account should have status" do
    account = Account.new
    account.balance = 0.0
    account.user_id = 1
    assert_not account.save
  end

  test "account should have balance" do
    account = Account.new
    account.status = 'pending'
    account.user_id = 1
    assert_not account.save
  end

  test "account with status/balance/user_id should be saved" do
    account = Account.new
    account.balance = 0.0
    account.status = 'pending'
    account.user_id = users(:homer).id
    assert account.save
  end

  # test "account should not allow negative balance" do
  #   transaction = Transaction.new
  #   transaction.kind = 'withdraw'
  #   transaction.amount = 5001
  #   transaction.status = 'approved'
  #   transaction.processed = false
  #   transaction.account_id = accounts(:one).id
  #   transaction.save
  #   assert accounts(:one).balance == 5000
  # end
  #
  # test "account deduct balance on withdrawal" do
  #   transaction = Transaction.new
  #   transaction.kind = 'withdraw'
  #   transaction.amount = 4999
  #   transaction.status = 'approved'
  #   transaction.processed = false
  #   transaction.account_id = accounts(:one).id
  #   transaction.save
  #   puts accounts(:one).balance
  #   assert accounts(:one).balance == 1
  # end

end
