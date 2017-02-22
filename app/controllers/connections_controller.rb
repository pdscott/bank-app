class ConnectionsController < ApplicationController
  before_action :set_connection, only: [:show, :edit, :update, :destroy]

  # GET /connections
  # GET /connections.json
  def index
    @connections = Connection.all
    if params[:name_search]
      @friends = User.where("name like ?", "%#{params[:name_search]}%")
    elsif params[:email_search]
      @friends = User.where("email like ?", "%#{params[:email_search]}%")
    else
      @friends = nil
    end
  end

  # GET /connections/1
  # GET /connections/1.json
  def show
  end

  # GET /connections/new
  def new
    @friend = params[:friend]
    @connection = Connection.new
  end

  # GET /connections/1/edit
  def edit
  end

  # POST /connections
  # POST /connections.json
  def create
    @connection = Connection.new(connection_params)

    if @connection.save
      redirect_to @connection, notice: 'Connection was successfully created.'
    else
       render :new
    end

  end

  # PATCH/PUT /connections/1
  # PATCH/PUT /connections/1.json
  def update
    respond_to do |format|
      if @connection.update(connection_params)
        format.html { redirect_to @connection, notice: 'Connection was successfully updated.' }
        format.json { render :show, status: :ok, location: @connection }
      else
        format.html { render :edit }
        format.json { render json: @connection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /connections/1
  # DELETE /connections/1.json
  def destroy
    @connection.destroy
    respond_to do |format|
      format.html { redirect_to user_connections_path(current_user), notice: 'Connection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_connection
    @connection = Connection.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def connection_params
    params.require(:connection).permit(:sender, :recipient, :status)
  end
end