require 'gcm'
class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
	logger.error(@message.msg)
    respond_to do |format|
      if @message.save
        format.html { redirect_to messages_url, notice: 'Message was successfully pushed.' }
        format.json { render action: 'show', status: :created, location: @message }
      else
        format.html { render action: 'new' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
	
		
	# Here we will send the notification to GCM using 'gcm' gem
	#require 'gcm'
	gcm = GCM.new("AIzaSyC8Evhuc9gSgjWH_ilGsOlNikA4iGOnRVM")
	options = {data: {message: @message.msg, title: @message.title}, collapse_key: "updated_score"}

	registration_ids= ["APA91bHjCkyrdoubBFEOBkwqNoCCAIRgdLKBuqnLOEvwYV1BFtKHcaIAy3sCAIpxyAYO-f-S5E2W4d13fw9fGdTTxMiDxUrgt668N3T1gq4-agdPz-u5ISRFB84OqdhXQIUjaHKzuvx3MrmK-6A83F217BsP5mO0-Q"]
	response = gcm.send(registration_ids, options)
	#logger.error(registration_ids)
	
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:msg, :title)
    end
end
