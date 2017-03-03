class UsersController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    if params[:filter] == 'Users'
      @users = User.where("role = 0")
      @filter = 'Users'
    elsif params[:filter] == 'Admins'
      @users = User.where("role > 0")
      @filter = 'Admins'
    else
      @users = User.all
      @filter = 'All'

    end
    authorize User

  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy

    #destroy accounts that the user had and any friend transactions containing those accounts.

    accounts = Account.where("user_id = ?", params[:id])
    accounts.each do  |a|
      transactions = Transaction.where("account_id = ? or 'from' = ? or 'to' = ?", a.id, a.id, a.id)
      transactions.each {|t| t.destroy}
      a.destroy
    end

    #also delete friend connections
    connections = Connection.where("sender = ? or recipient = ?", params[:id], params[:id])
    connections.each {|c| c.destroy }

    authorize user
    redirect_to users_path, :notice => "User deleted."

  end

  private

  def secure_params
    params.require(:user).permit(:role)
  end

end
