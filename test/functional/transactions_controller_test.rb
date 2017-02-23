require 'test_helper'


class ActionController::TestCase
  include Devise::Test::ControllerHelpers
end

class TransactionsControllerTest < ActionController::TestCase
  setup do
    @account = accounts(:one)
    @transaction = transactions(:one)
    sign_in users(:homer)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new, params: {account_id: accounts(:one).id}
    assert_response :success
  end

  test "should show transaction" do
    get :show, id: @transaction.id
    assert_response :success
  end
  #
  test "should get edit" do
    get :edit, id: @transaction
    assert_response :success
  end

  test "should update transaction" do
    put :update, id: @transaction, transaction: { status: @transaction.status }
    assert_response :success
  end


  test "should destroy transaction" do
    assert_difference('Transaction.count', -1) do
      delete :destroy, id: @transaction
    end
    assert_redirected_to account_path(@account)
  end

end