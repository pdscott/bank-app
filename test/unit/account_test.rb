require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  test "account should have name" do
    account = Account.new
    assert_not account.save
  end

  # test "account with name should be saved" do
  #   account = Account.new
  #   account.name = "Some title"
  #   assert category.save
  # end

end
