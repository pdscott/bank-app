class ConnectionsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    @connections = Connections.all
    authorize Connections
  end

  def show
    @connections = Connections.find(params[:id])
    authorize @connections
  end

  def update
    @connections = Connections.find(params[:id])
    authorize @connections
    if @connections.update_attributes(secure_params)
      redirect_to users_path, :notice => "Friend updated."
    else
      redirect_to users_path, :alert => "Unable to update Friend."
    end
  end

  def destroy
    user = Connections.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "Friend deleted."
  end

end
