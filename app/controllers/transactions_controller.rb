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

    if @transaction.save

      # implement all automatically approved transactions here.
      if @transaction.kind == 'withdraw' and @transaction.amount < 1000 and @transaction.processed == false
        account = Account.find(@transaction.account_id)
        if account.balance > @transaction.amount
          account.balance -= @transaction.amount
          account.save
          @transaction.status = 'approved'
          @transaction.processed = true
          @transaction.save
        end
      elsif @transaction.kind == 'transfer' and @transaction.processed == false
        account1 = Account.find(@transaction.from)
        account2 = Account.find(@transaction.to)
        if account1.user_id == account2.user_id and account1.balance > @transaction.amount
          account1.balance -= @transaction.amount
          account2.balance += @transaction.amount
          account1.save
          account2.save
          @transaction.status = 'approved'
          @transaction.processed = true
          @transaction.save
        end
      elsif @transaction.kind == 'send' and @transaction.processed == false
        account1 = Account.find(@transaction.from)
        account2 = Account.find(@transaction.to)
        if account1.balance > @transaction.amount
          account1.balance -= @transaction.amount
          account2.balance += @transaction.amount
          account1.save
          account2.save
          @transaction.status = 'approved'
          @transaction.processed = true
          @transaction.save
        end
      end

      redirect_to @transaction, notice: 'Transaction was successfully created.'
    else
       render :new
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update


    if @transaction.update(transaction_params)

      # implement all admin approved transactions here.
      if @transaction.kind == 'withdraw' and @transaction.status == 'approved'
        account = Account.find(@transaction.account_id)
        if account.balance > @transaction.amount
          account.balance -= @transaction.amount
          account.save
          @transaction.processed = true
          @transaction.save
        end
      elsif @transaction.kind == 'deposit' and @transaction.status == 'approved'
        account = Account.find(@transaction.account_id)
        account.balance += @transaction.amount
        account.save
        @transaction.processed = true
        @transaction.save
      end

      redirect_to @transaction, notice: 'Transaction was successfully updated.', id: @transaction.id
    else
      render :edit
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
