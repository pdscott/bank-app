class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  after_action :verify_authorized

  # GET /accounts
  # GET /accounts.json
  def index
    if params[:user_id]
      @accounts = Account.where("user_id = ?", params[:user_id])
      user = User.find(params[:user_id])
      authorize user
    else
      @accounts = Account.all
      user = User.find(1)
      authorize user
    end
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    @account = Account.find(params[:id])
    @transactions = Transaction.all
    user = User.find(@account.user_id)
    authorize user
  end

  # GET /accounts/new
  def new
    @account = Account.new
    @user = current_user
    authorize @user

  end

  # GET /accounts/1/edit
  def edit
    authorize User
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)

    if @account.save
      redirect_to @account, notice: 'Account was successfully created.'
    else
      render :new
    end

    user = User.find(@account.user_id)
    authorize user
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update

    if @account.update_attributes(account_params)
      redirect_to @account, notice: 'Account was successfully updated.'
    else
      render :edit
    end
    authorize User
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    account = Account.find(params[:id])
    # destroy all transactions containing this account.
    transactions = Transaction.where("account_id = ? or 'from' = ? or 'to' = ?", params[:id], params[:id], params[:id])
    transactions.each {|t| t.destroy}
    # then destroy the account
    account.destroy

    authorize User

    redirect_to accounts_url, notice: 'Account was successfully destroyed.'

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:number, :status, :balance, :user_id)
    end
end
