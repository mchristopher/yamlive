class StreamsController < ApplicationController

  #before_filter :authenticate_user!, :except => [:index, :show, :notify]
  before_filter :authenticate_user!

  include ::ZencoderAPIWrapper

  # GET /streams
  # GET /streams.xml
  def index
    @streams = Stream.all
    @active_streams = Stream.active
    @waiting_streams = Stream.waiting
    @finished_streams = Stream.finished

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @streams }
    end
  end

  # GET /streams/1
  # GET /streams/1.xml
  def show
    @stream = Stream.find(params[:id])
    @stream_uris = ZencoderAPIWrapper.stream_uris(@stream)

    if user_signed_in? && (current_user.id == @stream.user.id)
      @user_owns_stream = true
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @stream }
    end
  end

  # GET /streams/new
  # GET /streams/new.xml
  def new
    @stream = Stream.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @stream }
    end
  end

  # GET /streams/1/edit
  def edit
    @stream = Stream.find(params[:id])
  end

  # POST /streams
  # POST /streams.xml
  def create
    @stream = Stream.new(params[:stream])
    @stream.user = current_user
    @stream.state = "waiting"

    if @stream.save

      zc_stream = ZencoderAPIWrapper.create_new_stream(@stream)

      if zc_stream
        @stream.zc_job_id = zc_stream['id']
        @stream.zc_stream_name = zc_stream['stream_name']
        @stream.zc_stream_url = zc_stream['stream_url']
        @stream.save
      else
        @stream.delete
      end
    end

    respond_to do |format|
      if @stream.zc_job_id
        format.html { redirect_to(@stream, :notice => 'Stream was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /streams/1
  # PUT /streams/1.xml
  def update
    @stream = Stream.find(params[:id])

    respond_to do |format|
      if @stream.update_attributes(params[:stream])
        format.html { redirect_to(@stream, :notice => 'Stream was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @stream.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /streams/1
  # DELETE /streams/1.xml
  def destroy
    @stream = Stream.find(params[:id])
    @stream.destroy

    respond_to do |format|
      format.html { redirect_to(streams_url) }
      format.xml  { head :ok }
    end
  end

  # Stream Notifications - Received from Zencoder Dashboard
  # POST /streams/1/notify
  def notify
    @stream = Stream.find(params[:id])
    if params[:job][:state] == "processing"
      @stream.state = "active"
      @stream.save
    elsif params[:job][:state] != "waiting"
      @stream.state = "finished"
      @stream.save
    end

    respond_to do |format|
      format.html { redirect_to(streams_url) }
      format.xml { head :ok }
      format.json { head :ok }
    end
  end

  def broadcast
    @stream = Stream.find(params[:id])
    @stream_uris = ZencoderAPIWrapper.stream_uris(@stream)

    if user_signed_in? && (current_user.id == @stream.user.id)
      @user_owns_stream = true
    end
  end

end
