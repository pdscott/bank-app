class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
    @transaction = Transaction.find(params[:id])
    @account = Account.find(@transaction.account_id)
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
    @account = Account.find(params[:account_id])
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.kind == 'withdraw' && @transaction.amount < 1000
      account = Account.find(@transaction.account_id)
      if account.balance > @transaction.amount
        account.balance -= @transaction.amount
        account.save
        @transaction.processed = true
      end
    end

    if @transaction.save
      redirect_to @transaction, notice: 'Transaction was successfully created.'
    else
       render :new
    end

  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.', id: @transaction.id }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to account_url, notice: 'Transaction was successfully destroyed.'}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:kind, :amount, :status, :from, :to, :start_date, :eff_date, :account_id)
    end
end
