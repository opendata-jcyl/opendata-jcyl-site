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
  


  # metodos extra del controlador
  # 
  # query para obtener las estaciones, coordenadas y fecha actual
  # vale para el mapa de inicio y para la lista de estaciones
  # mapa /info_polens/mapa
  # mapa /info_polens/mapa.json
  def mapa
    @info_polens = InfoPolen.collection.aggregate(
        { "$project" => { "estaciones_old" => "$ESTACIONES", "coordenadas_old" => "$COORD", "fecha_old" => "$FECHA" } },
        { "$sort" => {"fecha_old" => 1} },
        { "$group" => { "_id" => "$estaciones_old" , "coordenadas" => { "$last" => "$coordenadas_old" }, "fecha" => { "$last" => "$fecha_old" } } },
        { "$sort" => {"_id" => 1} }
    )

    respond_to do |format|
      format.html #{ redirect_to info_polens_url }
      format.json { render json: @info_polens }
    end
  end



  # query para obtener los detalle de una estacion, se le pasa el nombre de la estacion y la fecha actual
  # mapa /info_polens/estacion
  # mapa /info_polens/estacion.json
  def estaciones

    param_estacion = params[:estacion]
    param_fecha = params[:fecha].to_i
    @info_polens = InfoPolen.where({"ESTACIONES" => param_estacion, "FECHA" => param_fecha}).order_by(:TIPOS_POLINICOS.asc)

    respond_to do |format|
      format.html #{ redirect_to info_polens_url }
      format.json { render json: @info_polens }
    end
  end


  # query para obtener los tipos de polen
  # mapa /info_polens/estacion
  # mapa /info_polens/estacion.json
  def tipospolen

    @info_polens = InfoPolen.collection.aggregate(
        { "$group" => { "_id" => "$TIPOS_POLINICOS" } },
        { "$sort" => {"_id" => 1} }
    )

    respond_to do |format|
      format.html #{ redirect_to info_polens_url }
      format.json { render json: @info_polens }
    end
  end


  # query para obtener los tipos de polen
  # mapa /info_polens/estacion
  # mapa /info_polens/estacion.json
  def detallepolen

    param_polen = params[:polen]

    @info_polens = InfoPolen.collection.aggregate(
               { "$match" => { "TIPOS_POLINICOS" => param_polen} },
               { "$project" => { "estaciones_old" => "$ESTACIONES", "tipos_polinicos_old" => "$TIPOS_POLINICOS", "fecha_old" => "$FECHA", "precedentes_old" => "$PRECEDENTES", "prevision_old" => "$PREVISION" } },
               { "$sort" => {"fecha_old" => 1} },
               { "$group" => { "_id" => "$estaciones_old", "fecha" => { "$last" => "$fecha_old" }, "precedentes" => { "$last" => "$precedentes_old" }, "prevision" => { "$last" => "$prevision_old" } } },
               { "$sort" => {"_id" => 1} }
    )

    respond_to do |format|
      format.html #{ redirect_to info_polens_url }
      format.json { render json: @info_polens }
    end
  end

    
end
