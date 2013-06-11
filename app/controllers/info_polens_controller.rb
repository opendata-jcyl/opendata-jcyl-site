class InfoPolensController < ApplicationController
  # GET /info_polens
  # GET /info_polens.json

  
  def index
    
    @info_polens = InfoPolen.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @info_polens }
    end
  end

  # GET /info_polens/1
  # GET /info_polens/1.json
  def show
    @info_polen = InfoPolen.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @info_polen }
    end
  end

  # GET /info_polens/new
  # GET /info_polens/new.json
  def new
    @info_polen = InfoPolen.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @info_polen }
    end
  end

  # GET /info_polens/1/edit
  def edit
    @info_polen = InfoPolen.find(params[:id])
  end

  # POST /info_polens
  # POST /info_polens.json
  def create
    @info_polen = InfoPolen.new(params[:info_polen])

    respond_to do |format|
      if @info_polen.save
        format.html { redirect_to @info_polen, notice: 'Info polen was successfully created.' }
        format.json { render json: @info_polen, status: :created, location: @info_polen }
      else
        format.html { render action: "new" }
        format.json { render json: @info_polen.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /info_polens/1
  # PUT /info_polens/1.json
  def update
    @info_polen = InfoPolen.find(params[:id])

    respond_to do |format|
      if @info_polen.update_attributes(params[:info_polen])
        format.html { redirect_to @info_polen, notice: 'Info polen was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @info_polen.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /info_polens/1
  # DELETE /info_polens/1.json
  def destroy
    @info_polen = InfoPolen.find(params[:id])
    @info_polen.destroy

    respond_to do |format|
      format.html { redirect_to info_polens_url }
      format.json { head :no_content }
    end
  end
end
